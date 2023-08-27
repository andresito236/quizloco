import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:quizloco/src/constants/routes.dart';
import 'package:quizloco/src/utils/app_bar_maker.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarMaker(context, title: "Inicio"),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Bienvenido, ${user?.email ?? 'UNKNOWN'}",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, MyRoutes.myTests.name);
              },
              child: Text('Revisa qué tests has creado'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, MyRoutes.tests.name);
              },
              child: Text('¡Atrévete y realiza un intento en cualquier test!'),
            ),
          ],
        ),
      ),
    );
  }
}
