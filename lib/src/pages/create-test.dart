import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quizloco/src/constants/routes.dart';
import 'package:quizloco/src/controllers/firestore_controller.dart';
import 'package:quizloco/src/controllers/question_controller.dart';
import 'package:quizloco/src/controllers/test_controller.dart';
import 'package:quizloco/src/models/test_model.dart';
import 'package:quizloco/src/widgets/question-form.dart';
import 'package:quizloco/src/widgets/submited-questions.dart';
import 'package:quizloco/src/widgets/test-general-info-form.dart';

class CreateTestPage extends StatefulWidget {
  @override
  _CreateTestPageState createState() => _CreateTestPageState();
}

class _CreateTestPageState extends State<CreateTestPage> {
  final testController = Get.put<TestController>(TestController());
  final questionController = Get.put<QuestionController>(QuestionController());
  bool isLoading = false;

  final firestoreController = FirestoreController();

  List<Widget> submitedQuestions = [];

  void submitTest() async {
    setState(() {
      isLoading = true;
    });
    String userId = await firestoreController.getUserId();

    final test = Test(
        name: testController.name,
        description: testController.description,
        questions: testController.questions,
        creator: userId);

    try {
      await firestoreController.addTest(test);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Test creado con éxito'),
        ),
      );
      testController.onClose();
      setState(() {
        isLoading = false;
      });
      Navigator.pushNamed(context, MyRoutes.home.name);
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
        title: const Text('Crear Quiz'),
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Column(
                children: [
                  TestGeneralInfoForm(
                    testController: testController,
                  ),
                  const Text(
                    'Preguntas',
                    style: TextStyle(fontSize: 20.0, color: Colors.blueGrey),
                  ),
                  const SizedBox(height: 16.0),
                  Obx(() {
                    if (testController.questions.isEmpty) {
                      return const Text('No questions Added');
                    } else {
                      final questionWidgets =
                          testController.questions.map((question) {
                        return SubmittedQuestions(question: question);
                      }).toList();

                      return Column(
                        children: questionWidgets,
                      );
                    }
                  }),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: QuestionForm(
                      questionController: questionController,
                      testController: testController,
                    ),
                  ),
                  FilledButton(
                    onPressed: () async {
                      submitTest();
                    },
                    child: const Text('Guardar Quiz'),
                  ),
                  const SizedBox(height: 16.0),
                ],
              ),
            ),
    );
  }
}
