import "package:cloud_firestore/cloud_firestore.dart";
import "package:firebase_auth/firebase_auth.dart";

FirebaseFirestore db = FirebaseFirestore.instance;

Future<List> getUser(String username) async {
  List users = [];
  CollectionReference userCollection = db.collection('user');
  QuerySnapshot queriedUsers =
      await userCollection.where('username', isEqualTo: username).get();

  queriedUsers.docs.forEach((document) {
    users.add(document.data());
  });
  return users;
}

Future<List> getUserByEmail(String email) async {
  List user = [];
  CollectionReference userCollection = db.collection('user');
  QuerySnapshot queriedUsers =
      await userCollection.where('email', isEqualTo: email).get();
  queriedUsers.docs.forEach((document) {
    user.add(document.data());
  });
  return user;
}

String? currentUserEmail() {
  String? email = "";
  FirebaseAuth.instance.authStateChanges().listen((User? user) {
    if (user != null) {
      email = user.email;
    }
  });
  return email;
}

Future<List> getTests() async {
  List tests = [];
  CollectionReference testCollection = db.collection('test');
  QuerySnapshot queriedTests = await testCollection.get();

  queriedTests.docs.forEach((document) {
    tests.add(document.data());
  });

  return tests;
}

Future<List> getTestsByUserId(String userId) async {
  List tests = [];
  CollectionReference userCollection = db.collection('test');
  QuerySnapshot queriedTests =
      await userCollection.where('user_id', isEqualTo: userId).get();

  queriedTests.docs.forEach((document) {
    tests.add(document.data());
  });

  return tests;
}
