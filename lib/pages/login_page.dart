import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:quizloco/widgets/my_button.dart';
import 'package:quizloco/widgets/my_text_field.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  // Función para ingresar al usuario.
  void signUserIn() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: emailController.text, 
      password: passwordController.text);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print("No se encontró el usuario.");
      } else if (e.code == 'wrong-password') {
        print("Contraseña incorrecta.");
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Icon(Icons.login, size: 100),
          MyTextField(
            controller: emailController,
            hintText: "Email",
            obscureText: false),  
          MyTextField(controller: passwordController,
          hintText: "Password", 
          obscureText: true),
          MyButton(onTap: signUserIn,
           message: "Sign in")
        ],
      ),
    );
  }
}