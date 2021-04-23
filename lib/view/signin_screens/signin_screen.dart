import 'package:clerk/constants.dart';
import 'package:clerk/view/signup_screen/signup_screen.dart';
import 'package:clerk/view_model/authintication_service/firebase_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'components/default_button.dart';
import 'components/Custom_form_field.dart';

class SignInScreen extends StatefulWidget {
  static String id = "Sign In Screen";

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  FirebaseAuth _auth = FirebaseAuth.instance;
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
        body: Padding(
          padding: EdgeInsets.all(40),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Spacer(),
                Image.asset("assets/images/clerk logo.png"),
                Spacer(),
                CustomFormField(
                  controller: _email,
                  hintText: "E-mail or username",
                  validator: (value) {
                    if (value.isEmpty) return "Invalid Email";
                  },
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                CustomFormField(
                  controller: _password,
                  hintText: "Password",
                  validator: (value) {
                    if (value.isEmpty) return "Invalid Password";
                  },
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                DefaultButton(
                  color: kPrimaryColor,
                  child: Center(
                    child: Text(
                      "SIGN IN",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 17,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  onPressed: () async {
                    if (_formKey.currentState.validate()) {
                      _authService.signInWithEmailAndPassword(
                          _email.text, _password.text, context);
                      SharedPreferences _prefs =
                      await SharedPreferences.getInstance();
                      _prefs.setBool("userLogin", true);
                    }
                  },
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                Text(
                  "Forget Password?",
                  style: TextStyle(
                      decoration: TextDecoration.underline,
                      color: kSecondaryColor,
                      fontSize: 17),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.04),
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
                SizedBox(height: MediaQuery.of(context).size.height * 0.04),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have an account? ",
                      style: TextStyle(color: kPrimaryColor, fontSize: 17),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, SignUpScreen.id);
                      },
                      child: Text(
                        "Sign Up",
                        style: TextStyle(
                            color: kSecondaryColor,
                            decoration: TextDecoration.underline,
                            fontSize: 17),
                      ),
                    )
                  ],
                ),
                Spacer(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  SnackBar buildSnackBar(BuildContext context) {
    return SnackBar(
      content: Text("please Sign With Valid Email"),
      backgroundColor: kPrimaryColor,
      duration: Duration(seconds: 5),
      elevation: 2,
    );
  }
}
