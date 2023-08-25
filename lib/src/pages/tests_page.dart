import 'package:flutter/material.dart';
import 'package:quizloco/src/utils/firebase_service.dart';

class TestsPage extends StatelessWidget {
  const TestsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: getTests(),
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

          return ListView.builder(
            itemCount: snapshot.data?.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(snapshot.data![index]['name'] ?? "test-x"),
                subtitle: Text(snapshot.data![index]['description'] ?? "test-x-description"),
              );
            }
          );
        },
      ),
    );
  }
}