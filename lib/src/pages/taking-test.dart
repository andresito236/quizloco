import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quizloco/src/constants/routes.dart';
import 'package:quizloco/src/controllers/answer_controller.dart';
import 'package:quizloco/src/controllers/firestore_controller.dart';
import 'package:quizloco/src/models/attempt_model.dart';
import 'package:quizloco/src/models/test_model.dart';
import 'package:quizloco/src/widgets/question.dart';

class TakingTestPage extends StatefulWidget {
  const TakingTestPage({super.key});

  @override
  State<TakingTestPage> createState() => _TakingTestPageState();
}

class _TakingTestPageState extends State<TakingTestPage> {
  final answercontroller = Get.put<AnswerController>(AnswerController());
  final firestoreController = FirestoreController();
  Test? test;
  int? userScore;
  List<bool?>? userAnswers;
  String testId = "";

  @override
  void initState() {
    super.initState();
    // _fetchTest();
    answercontroller.onClose();
  }

  Future<void> _fetchTest() async {
    Test fetchedTest = await firestoreController.getTest(testId);
    setState(() {
      test = fetchedTest;
      userAnswers = List.generate(
        test!.questions.length,
        (_) => null,
      );
    });
  }

  void submitTest() async {
    print(answercontroller.answers.length);
    print(test!.questions.length);
    if (answercontroller.answers.length != test!.questions.length) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text(
                'Tienes que enviar todas las respuestas antes de continuar'),
            duration: Duration(seconds: 2),
            backgroundColor: Colors.red,
            action: SnackBarAction(label: 'OK', onPressed: () {}),
            ),
      );
    } else {
      String userId = await firestoreController.getUserId();
      double totalScore = 0;
      List<int?> scores =
          answercontroller.answers.map((answer) => answer.score).toList();

      for (int i = 0; i < scores.length; i++) {
        if (scores[i] == 1) {
          totalScore++;
        }
      }

      totalScore = (totalScore / scores.length) * 100;

      final attempt = Attempt(
        attemptedAt: DateTime.now(),
        score: totalScore,
        testId: testId,
        userId: userId,
      );

      try {
        await firestoreController.addAttempt(attempt);

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Intento realizado!'),
          ),
        );

        answercontroller.onClose();

        Navigator.pushNamed(context, MyRoutes.resultPage.name,
            arguments: {'totalScore': totalScore});
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error: $e'),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic>? params =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;

    setState(() {
      testId = params!['testId'];
    });

    _fetchTest();

    return Scaffold(
      appBar: AppBar(
        title: Text('Taking Test'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              test == null ? '' : test!.name,
              style: const TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 12),
            Text(
              test == null ? '' : test!.description,
              style: const TextStyle(fontSize: 15),
            ),
            const SizedBox(height: 24),
            Expanded(
              child: ListView.builder(
                itemCount: test?.questions.length ?? 0,
                itemBuilder: (context, index) {
                  final question = test?.questions[index];
                  return QuestionWidget(
                    question: question!,
                    answerController: answercontroller,
                  );
                },
              ),
            ),
            ElevatedButton(
              onPressed: () {
                submitTest();
              },
              child: Text('Terminar Intento'),
            ),
          ],
        ),
      ),
    );
  }
}
