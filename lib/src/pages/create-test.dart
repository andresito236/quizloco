import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quizloco/src/constants/routes.dart';
import 'package:quizloco/src/controllers/firestore_controller.dart';
import 'package:quizloco/src/controllers/question_controller.dart';
import 'package:quizloco/src/controllers/test_controller.dart';
import 'package:quizloco/src/models/question_model.dart';
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

  final firestoreController = FirestoreController();

  List<Widget> submitedQuestions = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Crear Quiz'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            TestGeneralInfoForm(
              testController: testController,
            ),
            Obx(() {
              if (testController.questions.isEmpty) {
                return Text('No questions Added');
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
            QuestionForm(
              questionController: questionController,
              testController: testController,
            ),
            ElevatedButton(
              onPressed: () async {
                final test = Test(
                  name: testController.name,
                  description: testController.description,
                  questions: testController.questions,
                );
                // Llama al controlador de Firestore para guardar el quiz
                try {
                  await firestoreController.addTest(test);

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Test creado con éxito'),
                    ),
                  );
                  Navigator.pushNamed(context, MyRoutes.home.name);

                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Error: $e'),
                    ),
                  );
                }
              },
              child: Text('Guardar Quiz'),
            ),
          ],
        ),
      ),
    );
  }
}
