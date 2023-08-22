import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:quizloco/src/constants/routes.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final user = FirebaseAuth.instance.currentUser;

  void signUserOut() {
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(actions: [
        IconButton(onPressed: signUserOut, icon: Icon(Icons.logout))
      ]),
      body: Center(child: Column(
        children: [
          Text("LOGGED IN asssss: " + (user?.email ?? "UNKNOWN"), ),
          TextButton(onPressed: (){
            Navigator.pushNamed(context, MyRoutes.createTest.name);
          }, child: Text('Create Test'))
        ],
        )),
    );
  }
}
