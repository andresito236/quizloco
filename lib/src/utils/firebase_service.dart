import "package:cloud_firestore/cloud_firestore.dart";

FirebaseFirestore db = FirebaseFirestore.instance;


Future<List> getUser(String username) async {
  List users = [];
  CollectionReference userCollection = db.collection('user');
  QuerySnapshot queriedUsers = await userCollection.where('username', isEqualTo: username).get();

  queriedUsers.docs.forEach((document) {
    users.add(document.data());
  });
  return users;
}

Future<List> getTests() async {
  List tests = [];
  CollectionReference userCollection = db.collection('test');
  QuerySnapshot queriedTests = await userCollection.get();

  queriedTests.docs.forEach((document) {
    tests.add(document.data());
  });

  return tests;
}