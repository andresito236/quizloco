import 'package:flutter/material.dart';

// Botones para usar en la página de login/registro.

class MyButton extends StatelessWidget {

  final Function()? onTap;
  final String message;
  
  MyButton({
    super.key,
    required this.onTap,
    required this.message,
    });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(20),
          margin: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
          width: 200,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: Colors.black,
              width: 0.5
            ),
            color: Colors.green[100]
          ),
          child: Center(
            child: Text(message),
          ),
        ),
    );
  }
}