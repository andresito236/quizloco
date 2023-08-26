import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:quizloco/src/utils/app_bar_maker.dart';

import '../utils/firebase_service.dart';

class CurrentUserTestsPage extends StatelessWidget {
  const CurrentUserTestsPage({super.key});

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarMaker(context, title: "Mis tests"),
      body: FutureBuilder(
        future: getCurrentUserTests(),
        builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
         
          // Mostrar barra circular mientras carga
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          // Revisar que haya conexión
          if (snapshot.connectionState == ConnectionState.none) {
            return const Center(
              child: Text('No hay conexión'),
            );
          }

          return ListView.builder(
              itemCount: snapshot.data?.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(snapshot.data![index]['name'] ?? "test-x"),
                  subtitle: Text(snapshot.data![index]['description'] ??
                      "test-x-description"),
                );
              });
        },
      ),
    );
  }
}
