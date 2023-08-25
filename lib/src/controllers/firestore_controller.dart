import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:quizloco/src/models/test_model.dart';

class FirestoreController {
  final CollectionReference testsCollection = FirebaseFirestore.instance.collection('test');

  Future<void> addTest(Test test) async {
    try {
      await testsCollection.add({
        'name': test.name,
        'description': test.description,
        'questions': test.questions.map((p) => {
          'question': p.question,
          'options': p.options,
          'answers': p.answers,
          'type': p.type,
        }).toList(),
      });
    } catch (e) {
      print("Error al agregar el quiz: $e");
    }
  }

  Stream<QuerySnapshot> getTestsStream() {
    return testsCollection.snapshots();
  }
}
