import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:quizloco/src/constants/routes.dart';
import 'package:quizloco/src/utils/custom_toast.dart';
import 'package:quizloco/src/widgets/my_button.dart';
import 'package:quizloco/src/widgets/my_text_field.dart';

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
      final String message;
      switch (e.code) {
        case 'user-not-found': message = 'No se encontró el usuario'; break;
        case 'wrong-password': message = 'Contraseña incorrecta'; break;
        default: message = 'Las credenciales no son válidas';
      }
      showCustomToast(message);
  
    } catch (e) {
      showCustomToast("Ocurrió un error: $e");
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
            hintText: "Correo",
            obscureText: false),  
          MyTextField(controller: passwordController,
          hintText: "Contraseña", 
          obscureText: true),
          // Ingreso del usuario.
          MyButton(onTap: signUserIn,
           message: "Ingresar"),
          //  Navegación hacia página de registro.
          MyButton(onTap: () {
            Navigator.pushNamed(context, MyRoutes.register.name);
          },
           message: "Registrarse")
        ],
      ),
    );
  }
}