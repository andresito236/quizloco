import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:quizloco/src/constants/routes.dart';
import 'package:quizloco/src/utils/firebase_service.dart';
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
    Future<bool> register() async {
    try {
      // Revisar si confirmó su contraseña correctamente
      if (passwordController.text == confirmPasswordController.text) {
        // Revisar si el usuario creado es único o no.
        List user = await getUser(userController.text);      
        if (user.isEmpty) {
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: emailController.text,
            password: passwordController.text
          );
          await addUser(userController.text, emailController.text);
          return true; 
        } else {
          throw Exception("Este usuario ya existe.");  
        }     
      } else {
        throw Exception("Las contraseñas no coinciden, verifique que sean iguales.");
      }
    } catch (e) {
      Fluttertoast.showToast(
        msg: "$e",
        gravity: ToastGravity.CENTER,
        toastLength: Toast.LENGTH_SHORT,
        backgroundColor: Colors.red
      );
    }
    return false;
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
          const Icon(Icons.login, size: 100),
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
          MyButton(onTap: () async {
              if (await register()) {
                Navigator.pushNamed(context, MyRoutes.home.name);
              }
              
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