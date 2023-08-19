import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:quizloco/widgets/my_button.dart';
import 'package:quizloco/widgets/my_text_field.dart';

class RegisterPage extends StatelessWidget {
  RegisterPage({super.key});

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  // Función para ingresar al usuario.
  void register() async {
    try {

      if (passwordController.text == confirmPasswordController.text) {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text
        );
      }
    } catch (e) {
      
    }
  }

  Future addUser(String username, String email) async {
    await FirebaseFirestore.instance.collection("user").add({
      "username" : username,
      "email": email,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Icon(Icons.login, size: 100),
          MyTextField(
            controller: emailController,
            hintText: "Usuario",
            obscureText: false),
          MyTextField(
            controller: emailController,
            hintText: "Email",
            obscureText: false),  
          MyTextField(controller: passwordController,
          hintText: "Contraseña", 
          obscureText: true),
          MyTextField(controller: passwordController,
          hintText: "Confirmar contraseña", 
          obscureText: true),
          MyButton(onTap: register,
           message: "Registrarse")
        ],
      ),
    );
  }
}