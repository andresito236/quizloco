import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:quizloco/src/constants/routes.dart';
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
      if (e.code == 'user-not-found') {
        Fluttertoast.showToast(
        msg: "No se encontró el usuario",
        gravity: ToastGravity.CENTER,
        toastLength: Toast.LENGTH_SHORT,
        backgroundColor: Colors.red
        );
      } else if (e.code == 'wrong-password') {
        
        Fluttertoast.showToast(
        msg: "Contraseña incorrecta",
        gravity: ToastGravity.CENTER,
        toastLength: Toast.LENGTH_SHORT,
        backgroundColor: Colors.red
        );
      } else {
        Fluttertoast.showToast(
        msg: "Las credenciales no son válidas",
        gravity: ToastGravity.CENTER,
        toastLength: Toast.LENGTH_SHORT,
        backgroundColor: Colors.red
        );
      }
    } catch (e) {
      Fluttertoast.showToast(
        msg: "Ocurrió un error: ${e.toString()}",
        gravity: ToastGravity.CENTER,
        toastLength: Toast.LENGTH_SHORT,
        backgroundColor: Colors.red
        );
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