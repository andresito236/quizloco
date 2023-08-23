import 'package:flutter/material.dart';
import 'package:quizloco/src/utils/firebase_service.dart';

class TestsPage extends StatelessWidget {
  const TestsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: TextButton(
          onPressed: () async {
            List tests = await getTests();
            print(tests[0]["description"]);
          }, 
          child: Text("Print results")
        ),
      ),
    );
  }
}