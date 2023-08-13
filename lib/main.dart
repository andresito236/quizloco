import 'package:flutter/material.dart';

// Importaciones para Firebase
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quizloco',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Quizloco'),
        ),
        body: const Center(
          child: Text('Quizloco'),
        ),
      ),
    );
  }
}
