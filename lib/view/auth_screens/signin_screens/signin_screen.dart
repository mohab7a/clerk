import 'package:clerk/constants.dart';
import 'package:clerk/view_model/authentication%20_service/firebase_service.dart';
import 'package:flutter/material.dart';
import 'components/sign_in_body.dart';

class SignInScreen extends StatefulWidget {
  static String id = "Sign In Screen";

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _email = TextEditingController();

  TextEditingController _password = TextEditingController();

  FireBaseService _authService = FireBaseService();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: kBackgroundColor,
        body: SignInBody(
            formKey: _formKey,
            email: _email,
            password: _password,
            authService: _authService),
      ),
    );
  }
}
