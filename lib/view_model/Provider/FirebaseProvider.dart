import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FireStoreProvider extends ChangeNotifier {
  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseFirestore _fireStore = FirebaseFirestore.instance;
  Map<String, dynamic> data;

  void setData({TextEditingController name, userName, password}) {
    _fireStore
        .collection("Users")
        .doc(_auth.currentUser.email)
        .set({"name": name, "username": userName, "password": password});
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
