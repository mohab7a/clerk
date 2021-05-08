import 'package:clerk/view/auth_screens/signin_screens/components/snack_bar.dart';
import 'package:clerk/view/auth_screens/signup_screen/signup_screen.dart';
import 'package:clerk/view_model/authintication_service/firebase_service.dart';
import 'package:flutter/material.dart';

import '../../../../constants.dart';
import 'Custom_form_field.dart';
import 'default_button.dart';

class SignInBody extends StatelessWidget {
  const SignInBody({
    Key key,
    @required GlobalKey<FormState> formKey,
    @required TextEditingController email,
    @required TextEditingController password,
    @required FireBaseService authService,
  })  : _formKey = formKey,
        _email = email,
        _password = password,
        _authService = authService,
        super(key: key);

  final GlobalKey<FormState> _formKey;
  final TextEditingController _email;
  final TextEditingController _password;
  final FireBaseService _authService;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(40),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            Spacer(),
            Image.asset(
              "assets/images/clerk logo.png",
              width: MediaQuery.of(context).size.width * 0.6,
            ),
            Spacer(),
            CustomFormField(
              secure: false,
              controller: _email,
              hintText: "E-mail or username",
              validator: (value) {
                if (value.isEmpty) return "Invalid Email";
              },
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.03),
            CustomFormField(
              secure: true,
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
                } else
                  signInSnackBar(context, "Please Sign in With Valid Email");
              },
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.03),
            Text(
              "Forget Password?",
              style: TextStyle(
                  decoration: TextDecoration.underline,
                  color: kSecondaryColor,
                  fontSize: 15),
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
    );
  }
}
