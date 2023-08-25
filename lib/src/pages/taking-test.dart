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

  @override
  void initState() {
    super.initState();
    _fetchTest();
  }

  Future<void> _fetchTest() async {
    Test fetchedTest =
        await firestoreController.getTest("mMQeWtUYRYszOLrlFnjI");
    if (fetchedTest == null) {
      print('loading...');
    } else {
      setState(() {
        test = fetchedTest;
        userAnswers = List.generate(
          test!.questions.length,
          (_) => null,
        );
      });
    }
  }

  void submitTest() async {
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

    print(totalScore);

    final attempt = Attempt(
      attemptedAt: DateTime.now(),
      score: totalScore,
      testId: "mMQeWtUYRYszOLrlFnjI",
      userId: userId,
    );

    try {
      await firestoreController.addAttempt(attempt);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Test creado con éxito'),
        ),
      );
      Navigator.pushNamed(context, MyRoutes.resultPage.name, arguments: {'totalScore': totalScore});
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: $e'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Taking Test'),
      ),
      body: Center(
        child: test == null
            ? const CircularProgressIndicator()
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    test!.name,
                    style: const TextStyle(fontSize: 20),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    test!.description,
                    style: const TextStyle(fontSize: 15),
                  ),
                  const SizedBox(height: 20),
                  Expanded(
                    child: ListView.builder(
                      itemCount: test!.questions.length,
                      itemBuilder: (context, index) {
                        final question = test!.questions[index];
                        return QuestionWidget(
                          question: question,
                          answerController: answercontroller,
                        );
                      },
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      submitTest();
                    },
                    child: Text('Submit Test'),
                  ),
                ],
              ),
      ),
    );
  }
}
