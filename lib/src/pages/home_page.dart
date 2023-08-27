import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:quizloco/src/constants/routes.dart';
import 'package:quizloco/src/utils/app_bar_maker.dart';
import 'package:quizloco/src/widgets/my_button.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final user = FirebaseAuth.instance.currentUser;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarMaker(context, title: "Inicio"),
      body: Center(child: Column(
        children: [
          Text("Bienvenido " + (user?.email ?? "UNKNOWN"), ),
          MyButton(onTap: (){
            Navigator.pushNamed(context, MyRoutes.createTest.name);
          }, message: "Crea un test"),
          MyButton(onTap: () {
            Navigator.pushNamed(context, MyRoutes.myTests.name);
          }, message: "Mis tests",),
          MyButton(onTap: () {
            Navigator.pushNamed(context, MyRoutes.tests.name);
          }, message: "Todos los tests"),
        ],
        )),
    );
  }
}
