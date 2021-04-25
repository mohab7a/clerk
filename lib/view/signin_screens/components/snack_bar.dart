import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../../constants.dart';

signInSnackBar(context, text) {
  FirebaseAuth _auth = FirebaseAuth.instance;
  if (_auth.currentUser == null)
    return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(text),
      backgroundColor: kPrimaryColor,
      duration: Duration(seconds: 1),
    ));
}
