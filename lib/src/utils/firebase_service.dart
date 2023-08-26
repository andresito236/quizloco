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

Future<String> getUserIdByEmail(String email) async {
  List user = [];
  CollectionReference userCollection = db.collection('user');
  QuerySnapshot queriedUsers =
      await userCollection.where('email', isEqualTo: email).get();
  queriedUsers.docs.forEach((document) {
    user.add(document.reference.id);
  });
  return user.isNotEmpty ? user[0] : "";
}

String getCurrentUserEmail() {
  String? email = "";
  User? user = FirebaseAuth.instance.currentUser;
  if (user != null) {
    return user.email ?? "";
  }
  return email;
}

String getCurrentUserId() {
  String id = "";
  User? user = FirebaseAuth.instance.currentUser;
  if (user != null) {
    return user.uid;
  }
  return id;
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
  CollectionReference testCollection = db.collection('test');
  QuerySnapshot queriedTests =
      await testCollection.where('user_id', isEqualTo: userId).get();

  queriedTests.docs.forEach((document) {
    tests.add(document.data());
  });

  return tests;
}

Future<List> getCurrentUserTests() async {
  List tests = [];
  String userId = getCurrentUserId();
  tests = await getTestsByUserId(userId);
  return tests;
}
