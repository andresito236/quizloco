import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:quizloco/src/models/attempt_model.dart';
import 'package:quizloco/src/models/question_model.dart';
import 'package:quizloco/src/models/test_model.dart';

class FirestoreController {
  final CollectionReference testsCollection =
      FirebaseFirestore.instance.collection('test');
  final CollectionReference attemptsCollection =
      FirebaseFirestore.instance.collection('attempts');
  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('user');

  Future<void> addTest(Test test) async {
    try {
      await testsCollection.add({
        'name': test.name,
        'description': test.description,
        'questions': test.questions
            .map((p) => {
                  'question': p.question,
                  'options': p.options,
                  'answers': p.answers,
                  'type': p.type,
                })
            .toList(),
      });
    } catch (e) {
      print("Error al agregar el quiz: $e");
    }
  }

  Future<Test> getTest(String id) async {
    Test test;
    final DocumentReference docRef = testsCollection.doc(id);

    DocumentSnapshot doc = await docRef.get();
    if (doc.exists) {
      print(doc.data());
      test = Test(
          name: doc["name"],
          description: doc["description"],
          questions: List<Question>.from(
            doc["questions"]
                .map((p) => Question(
                      question: p["question"],
                      options:
                          List<String>.from(p["options"].map((opt) => opt)),
                      answers:
                          List<String>.from(p["answers"].map((opt) => opt)),
                      type: p["type"],
                    ))
                .toList(),
          ));
    } else {
      test = Test(name: '', description: '', questions: []);
    }

    return test;
  }

  Future<void> addAttempt(Attempt attempt) async {
    try {
      await attemptsCollection.add({
        'attemptedAt': attempt.attemptedAt,
        'score': attempt.score,
        'testId': attempt.testId,
        'userId': attempt.userId,
      });
    } catch (e) {
      print("Error al agregar el intento: $e");
    }
  }

  Future<String> getUserId() async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    User? user = _auth.currentUser;

    if (user != null) {
      return user.uid;
    } else {
      print('No hay usuario autenticado');
      return '';
    }
  }

  Stream<QuerySnapshot> getTestsStream() {
    return testsCollection.snapshots();
  }
}
