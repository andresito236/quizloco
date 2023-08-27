import 'package:flutter/material.dart';
import 'package:quizloco/src/constants/routes.dart';
import 'package:quizloco/src/utils/app_bar_maker.dart';
import 'package:quizloco/src/utils/firebase_service.dart';
import 'package:quizloco/src/widgets/my_button.dart';

class TestsPage extends StatelessWidget {
  TestsPage({super.key, required this.isCurrentUser});

  final bool isCurrentUser;
  Function testGetter = () {};

  @override
  Widget build(BuildContext context) {
    testGetter = isCurrentUser ? getCurrentUserTests : getTests; 
    return Scaffold(
      appBar: appBarMaker(context, title: "Todos los tests"),
      body: FutureBuilder(
        future: testGetter(),
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
              child: ElevatedButton(onPressed: () {
                Navigator.pushNamed(context, MyRoutes.createTest.name);
              }, child: const Text('Crea un test!'))
            );
          }

          return ListView.builder(
            itemCount: snapshot.data?.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(snapshot.data![index]['name'] ?? "test-x"),
                subtitle: Text(snapshot.data![index]['description'] ?? "test-x-description"),
                trailing: const Icon(Icons.arrow_forward),
                onTap: () {
                  Navigator.pushNamed(context, MyRoutes.takingTest.name, arguments: {
                    'testId' : snapshot.data![index]['id']
                  });
                }
              );
            }
          );
        },
      ),
    );
  }
}