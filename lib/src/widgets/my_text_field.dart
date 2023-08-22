import 'package:flutter/material.dart';

// Text fields personalizados para las páginas de login y registro.

class MyTextField extends StatelessWidget {
  
  final TextEditingController controller;
  final String hintText;
  final bool obscureText;
  
  const MyTextField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.obscureText,
    });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 25.0),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
          // Agregar estilos
          hintText: hintText
        ),

      ),
    );
  }
}