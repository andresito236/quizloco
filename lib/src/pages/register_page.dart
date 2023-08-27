import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:quizloco/src/constants/routes.dart';
import 'package:quizloco/src/utils/custom_toast.dart';
import 'package:quizloco/src/utils/firebase_service.dart';
import 'package:quizloco/src/widgets/my_button.dart';
import 'package:quizloco/src/widgets/my_text_field.dart';
import 'package:fluttertoast/fluttertoast.dart';

class RegisterPage extends StatefulWidget {
  RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final userController = TextEditingController();

  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  final confirmPasswordController = TextEditingController();

  bool isLoading = false;

  // Función para ingresar al usuario.
    Future<bool> register() async {
    try {
      setState(() {
        isLoading = true;
      });
      // Revisar si confirmó su contraseña correctamente
      if (passwordController.text == confirmPasswordController.text) {
        // Revisar si el usuario creado es único o no.
        List user = await getUser(userController.text);      
        if (user.isEmpty) {
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: emailController.text,
            password: passwordController.text
          );
          await addUser(userController.text, emailController.text, getCurrentUserId());
          return true; 
        } else {
          throw Exception("Este usuario ya existe.");  
        }     
      } else {
        throw Exception("Las contraseñas no coinciden, verifique que sean iguales.");
      }
    } catch (e) {
      showCustomToast("$e");
    }
    return false;
  }

  Future addUser(String username, String email, String id) async {
    await FirebaseFirestore.instance.collection("user").doc(id).set({
      "username" : username,
      "email": email,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const Image(image: AssetImage('assets/test-icon.png'),),
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
              SizedBox(height: 40,),
              // Botón para registrarse
              ElevatedButton(
              onPressed:() async {
                  if (await register()) {
                    Navigator.pushNamed(context, MyRoutes.home.name);
                  }
                  setState(() {
                    isLoading = false;
                  });
                },
              child: Text("Registrarse"),
              style: ElevatedButton.styleFrom(
                fixedSize: Size(320, 40),
              ),
            ),
            SizedBox(height: 20,),
              ElevatedButton(
              onPressed:() async {
                  Navigator.pushNamed(context, MyRoutes.login.name);
                },
              child: Text("Regresar"),
              style: ElevatedButton.styleFrom(
                fixedSize: Size(320, 40),
              ),
            ),
              
              if (isLoading) const Center(child: SizedBox(width: 80, height: 80, child: CircularProgressIndicator()),),
            ],
          ),
        ),
      ),
    );
  }
}