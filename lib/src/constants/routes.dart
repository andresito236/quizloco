

import 'package:quizloco/src/pages/create-test.dart';
import 'package:quizloco/src/pages/home_page.dart';
import 'package:quizloco/src/pages/login_page.dart';
import 'package:quizloco/src/pages/current_user_tests_page.dart';
import 'package:quizloco/src/pages/register_page.dart';
import 'package:quizloco/src/pages/result_page.dart';
import 'package:quizloco/src/pages/taking-test.dart';
import 'package:quizloco/src/pages/all_tests_page.dart';

enum MyRoutes { login, home, register, createTest, tests, takingTest, resultPage, myTests}

final routes = {
  MyRoutes.login.name: (context) => LoginPage(),
  MyRoutes.home.name: (context) => HomePage(),
  MyRoutes.register.name: (context) => RegisterPage(),
  MyRoutes.createTest.name: (context) => CreateTestPage(),
  MyRoutes.myTests.name: (context) => CurrentUserTestsPage(),
  MyRoutes.tests.name: (context) => AllTestsPage(),
  MyRoutes.takingTest.name: (context) => TakingTestPage(),
  MyRoutes.resultPage.name: (context) => ResultPage(),
};