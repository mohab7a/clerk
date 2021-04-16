import 'package:clerk/view/home_screen/home_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FireBaseService {
  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseFirestore _fireStore = FirebaseFirestore.instance;
  void signInWithEmailAndPassword(var email, password, context) async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    _prefs.setBool("userLogin", true);
    _auth.signInWithEmailAndPassword(email: email, password: password);
    Navigator.pushReplacementNamed(context, HomeScreen.id);
  }
  void createEmailAndPassword(
      var email, password, name, username, context) async {
    await _auth.createUserWithEmailAndPassword(
        email: email, password: password);
    _fireStore.collection("Users").doc(name).set({
      "name": name,
      "email": email,
      "username": username,
      "password": password
    }).then((value) => Navigator.pushNamed(context, HomeScreen.id));
  }
}
