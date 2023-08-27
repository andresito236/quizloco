import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:quizloco/src/controllers/firestore_controller.dart';

import '../utils/app_bar_maker.dart';

class TestAttemptsPage extends StatelessWidget {
  const TestAttemptsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic>? params = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    return Scaffold(
      appBar: appBarMaker(context, title: params?['testName']),
      body: FutureBuilder(
        future: FirestoreController().getTestAttempts(params?['testId'] ?? ''),
        builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
          
          // Mostrar barra circular mientras carga
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator(),);
          }

          // Revisar que haya conexión
          if(snapshot.connectionState == ConnectionState.none) {
            return const Center(
              child: Text('No hay conexión'),
            );
          }

          if(snapshot.data?.length == 0) {
            return Center(
              child: Text("Nadie ha tomado este test.")
            );
          }

          return ListView.builder(
            itemCount: snapshot.data?.length,
            itemBuilder: (context, index) {
              DateTime attemptedAt = (snapshot.data![index]['attemptedAt'] as Timestamp).toDate();
              String attemptedString = "Intentó el: ${attemptedAt.toString()}";
              return ListTile(
                title: Text(snapshot.data![index]['username'] ?? "Error."),
                subtitle: Text(attemptedString),
                trailing: Text("${snapshot.data![index]['score']}"),
              );
            }
          );
        },
      ),
    );
  }
}