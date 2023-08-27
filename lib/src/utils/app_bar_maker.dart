import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

void signUserOut(BuildContext context) {
    showConfirmationModal(context).then((option) {
      if (option == 'logout') {
        FirebaseAuth.instance.signOut();
        Navigator.pushNamed(context, '/');
      }
    });
}

Future<String?> showConfirmationModal(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('¿Está seguro de querer salir?'),
          content: SingleChildScrollView(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                GestureDetector(
                  child: const Text('Cancelar'),
                  onTap: () {
                    Navigator.pop(context, 'cancel');
                  },
                ),
                SizedBox(width: 20,),
                GestureDetector(
                  child: const Text('Salir'),
                  onTap: () {
                    Navigator.pop(context, 'logout');
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

AppBar appBarMaker(BuildContext context, {String title = ""}) {
  final user = FirebaseAuth.instance.currentUser;

  return AppBar(
    title: Text(title),
    actions: [
      Text('${user?.email}'),
        IconButton(onPressed: () {
          signUserOut(context);
        }, icon: Icon(Icons.logout))
  ]);
}