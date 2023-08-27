import 'package:flutter/material.dart';
import 'package:quizloco/src/constants/routes.dart';
import 'package:quizloco/src/models/test_model.dart';

class ResultPage extends StatelessWidget {
  const ResultPage({Key? key}) : super(key: key); // Usa Key? key en lugar de super.key

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic>? params = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;

    if (params == null || !params.containsKey('totalScore')) {
      // Manejar el caso en el que los argumentos no están presentes o faltan
      return Scaffold(
        body: Center(
          child: Text('Los argumentos son inválidos o faltan.'),
        ),
      );
    }

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Resultado',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Total de puntos: ${params['totalScore']}',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, MyRoutes.home.name);
              },
              child: Text('Ir a inicio'),
            ),
          ],
        ),
      ),
    );
  }
}
