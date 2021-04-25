import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FireStoreProvider extends ChangeNotifier {
  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseFirestore _fireStore = FirebaseFirestore.instance;
  Map<String, dynamic> data;

  void updateData({
    String key,
    value,
  }) {
    _fireStore
        .collection("Users")
        .doc(_auth.currentUser.email)
        .update({key: value});
    notifyListeners();
  }

  Future getData() async {
    final DocumentReference document = FirebaseFirestore.instance
        .collection("Users")
        .doc(_auth.currentUser.email);
    await document.get().then((snapshot) async {
      data = snapshot.data();
    });
  }
}
