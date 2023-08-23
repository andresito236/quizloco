import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:quizloco/src/constants/routes.dart';
import 'package:quizloco/src/widgets/my_button.dart';
import 'package:quizloco/src/widgets/my_text_field.dart';
import 'package:fluttertoast/fluttertoast.dart';

class RegisterPage extends StatelessWidget {
  RegisterPage({super.key});
  
  final userController = TextEditingController();
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
        await addUser(userController.text, emailController.text); 
      } else {
        throw Exception("Las contraseñass no coinciden, verifique que sean iguales.");
      }
    } catch (e) {
      Fluttertoast.showToast(
        msg: "Error en la función de register: ${e.toString()}",
        gravity: ToastGravity.CENTER,
        toastLength: Toast.LENGTH_SHORT,
        backgroundColor: Colors.red
      );
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
            controller: userController,
            hintText: "Usuario",
            obscureText: false),
          MyTextField(
            controller: emailController,
            hintText: "Email",
            obscureText: false),  
          MyTextField(controller: passwordController,
          hintText: "Contraseña", 
          obscureText: true),
          MyTextField(controller: confirmPasswordController,
          hintText: "Confirmar contraseña", 
          obscureText: true),
          // Botón para registrarse
          MyButton(onTap: () {
              register();
              Navigator.pushNamed(context, MyRoutes.home.name);
            },
           message: "Registrarse"),
          MyButton(onTap: () {
            Navigator.pushNamed(context, MyRoutes.login.name);
          },
            message: "Regresar",)
        ],
      ),
    );
  }
}