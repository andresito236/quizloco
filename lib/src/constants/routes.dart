

import 'package:quizloco/src/pages/create-test.dart';
import 'package:quizloco/src/pages/home_page.dart';
import 'package:quizloco/src/pages/login_page.dart';
import 'package:quizloco/src/pages/register_page.dart';
import 'package:quizloco/src/pages/result_page.dart';
import 'package:quizloco/src/pages/taking-test.dart';
import 'package:quizloco/src/pages/tests_page.dart';

enum MyRoutes { login, home, register, createTest, tests, takingTest, resultPage}

final routes = {
  MyRoutes.login.name: (context) => LoginPage(),
  MyRoutes.home.name: (context) => HomePage(),
  MyRoutes.register.name: (context) => RegisterPage(),
  MyRoutes.createTest.name: (context) => CreateTestPage(),
  MyRoutes.tests.name: (context) => TestsPage(),
  MyRoutes.takingTest.name: (context) => TakingTestPage(),
  MyRoutes.resultPage.name: (context) => ResultPage(),
};