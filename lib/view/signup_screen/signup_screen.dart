import 'package:clerk/constants.dart';
import 'package:clerk/view/signin_screens/components/Custom_form_field.dart';
import 'package:clerk/view/signin_screens/components/default_button.dart';
import 'package:clerk/view/signin_screens/signin_screen.dart';
import 'package:clerk/view_model/authintication_service/firebase_service.dart';
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
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: backgroundColor,
        body: Padding(
          padding: EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Row(
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Image.asset(
                        "assets/images/Arrow back.png",
                        width: MediaQuery.of(context).size.width * 0.07,
                      ),
                    ),
                    SizedBox(width: MediaQuery.of(context).size.width * 0.15),
                    Text(
                      "Create account",
                      style: TextStyle(
                          color: kPrimaryColor,
                          fontSize: 24,
                          fontWeight: FontWeight.bold),
                    )
                  ],
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.04),
                CustomFormField(
                  controller: _name,
                  hintText: "Name",
                  validator: (value) {
                    if (value.isEmpty) return "Please enter your name";
                  },
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.025),
                CustomFormField(
                  hintText: "Email-address",
                  controller: _email,
                  validator: (value) {
                    if (value.isEmpty) return "Please enter valid email";
                  },
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.025),
                CustomFormField(
                    hintText: "Username",
                    controller: _userName,
                    validator: (value) {
                      if (value.isEmpty) return "Please enter valid username";
                    }),
                SizedBox(height: MediaQuery.of(context).size.height * 0.025),
                CustomFormField(
                  hintText: "Password",
                  controller: _password,
                  validator: (value) {
                    if (value.isEmpty || value.length < 8)
                      return "Please enter Strong password";
                  },
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.025),
                CustomFormField(
                  hintText: "Confirm password",
                  validator: (value) {
                    if (value.isEmpty || value != _password.text)
                      return "Password don't match";
                  },
                ),
                Spacer(),
                DefaultButton(
                  color: kPrimaryColor,
                  child: Center(
                    child: Text(
                      "SIGN UP",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  press: () {
                    if (_formKey.currentState.validate()) {
                      _authService.createEmailAndPassword(_email.text,
                          _password.text, _name.text, _userName.text, context);
                    }
                  },
                ),
                Spacer(),
                DefaultButton(
                  color: Colors.white,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        "assets/images/Google.png",
                        width: MediaQuery.of(context).size.width * 0.06,
                      ),
                      SizedBox(width: MediaQuery.of(context).size.width * 0.02),
                      Text(
                        "Continue With Google",
                        style: TextStyle(
                            color: kPrimaryColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 17),
                      )
                    ],
                  ),
                ),
                Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Do you have an account? ",
                      style: TextStyle(color: kPrimaryColor, fontSize: 17),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, SignUpScreen.id);
                      },
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, SignInScreen.id);
                        },
                        child: Text(
                          "Sign In",
                          style: TextStyle(
                              color: kSecondaryColor,
                              decoration: TextDecoration.underline,
                              fontSize: 17),
                        ),
                      ),
                    )
                  ],
                ),
                Spacer()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
