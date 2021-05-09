import 'package:clerk/view/home_screen/home_screen.dart';
import 'package:clerk/view/auth_screens/signin_screens/signin_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FireBaseService {
  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseFirestore _fireStore = FirebaseFirestore.instance;

  void signInWithEmailAndPassword(var email, password, context) async {
    await _auth.signInWithEmailAndPassword(email: email, password: password);
    Navigator.pushNamedAndRemoveUntil(context, HomeScreen.id, (route) => false);
  }

  void createEmailAndPassword(
      var email, password, name, username, context) async {
    await _auth
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) => _fireStore
                .collection("Users")
                .doc(_auth.currentUser.email)
                .set({
              "name": name,
              "email": email,
              "username": username,
              "password": password,
              "userImage": ""
            }).then((value) => Navigator.pushNamedAndRemoveUntil(
                    context, HomeScreen.id, (route) => false)));
  }

  void signOut(context) async {
    await _auth.signOut().then((value) => Navigator.pushNamedAndRemoveUntil(
        context, SignInScreen.id, (route) => false));
  }
}