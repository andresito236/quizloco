import 'package:flutter/material.dart';
import 'package:quizloco/src/models/question_model.dart';

class SubmittedQuestions extends StatelessWidget {
  Question question;

  SubmittedQuestions({super.key, required this.question});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsetsDirectional.symmetric(horizontal: 16.0),
          padding: EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5.0),
            color: Color.fromARGB(54, 75, 93, 200),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text('Pregunta: ${question.question}'),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Tipo: ${question.type}'),
                  Text("Respuesta: ${question.answers?.join(' ')}"),
                ],
              ),
            ],
          ),
        ),
        SizedBox(height: 20.0),
      ],
    );
  }
}
