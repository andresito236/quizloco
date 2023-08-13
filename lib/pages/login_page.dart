import 'package:flutter/material.dart';
import 'package:quizloco/widgets/my_button.dart';
import 'package:quizloco/widgets/my_text_field.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          MyTextField(
            controller: emailController,
            hintText: "Email",
            obscureText: false),
          MyTextField(controller: passwordController,
          hintText: "Password", 
          obscureText: true),
          MyButton(onTap: () {
            print("Tapped!");
          }, message: "Sign in")
        ],
      ),
    );
  }
}