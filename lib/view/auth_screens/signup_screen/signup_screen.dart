import 'package:clerk/constants.dart';
import 'package:clerk/view/auth_screens/signup_screen/components/sign_up_body.dart';
import 'package:clerk/view_model/authentication%20_service/firebase_service.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget {
  static String id = "Sign UP Screen";

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  FireBaseService _authService = FireBaseService();
  TextEditingController _name = TextEditingController();
  TextEditingController _email = TextEditingController();
  TextEditingController _userName = TextEditingController();
  TextEditingController _password = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: kBackgroundColor,
          body: SignUpBody(
              formKey: _formKey,
              name: _name,
              email: _email,
              userName: _userName,
              password: _password,
              authService: _authService),
        ),
      ),
    );
  }
}
