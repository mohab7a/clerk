import 'package:clerk/view/auth_screens/signin_screens/components/Custom_form_field.dart';
import 'package:clerk/view/auth_screens/signin_screens/components/default_button.dart';
import 'package:clerk/view/auth_screens/signin_screens/signin_screen.dart';
import 'package:clerk/view/auth_screens/signup_screen/signup_screen.dart';
import 'package:clerk/view_model/authentication%20_service/firebase_service.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../constants.dart';

class SignUpBody extends StatelessWidget {
  const SignUpBody({
    Key key,
    @required GlobalKey<FormState> formKey,
    @required TextEditingController name,
    @required TextEditingController email,
    @required TextEditingController userName,
    @required TextEditingController password,
    @required FireBaseService authService,
  })  : _formKey = formKey,
        _name = name,
        _email = email,
        _userName = userName,
        _password = password,
        _authService = authService,
        super(key: key);

  final GlobalKey<FormState> _formKey;
  final TextEditingController _name;
  final TextEditingController _email;
  final TextEditingController _userName;
  final TextEditingController _password;
  final FireBaseService _authService;

  @override
  Widget build(BuildContext context) {
    return Padding(
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
              secure: false,
              controller: _name,
              hintText: "Name",
              validator: (value) {
                if (value.isEmpty) return "Please enter your name";
              },
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.025),
            CustomFormField(
              secure: false,
              hintText: "Email-address",
              controller: _email,
              validator: (value) {
                if (value.isEmpty) return "Please enter valid email";
              },
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.025),
            CustomFormField(
                secure: false,
                hintText: "Username",
                controller: _userName,
                validator: (value) {
                  if (value.isEmpty) return "Please enter valid username";
                }),
            SizedBox(height: MediaQuery.of(context).size.height * 0.025),
            CustomFormField(
              secure: true,
              hintText: "Password",
              controller: _password,
              validator: (value) {
                if (value.isEmpty || value.length < 8)
                  return "Please enter Strong password";
              },
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.025),
            CustomFormField(
              secure: true,
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
                onPressed: () async {
                  if (_formKey.currentState.validate()) {
                    SharedPreferences _prefs =
                        await SharedPreferences.getInstance();
                    _prefs.setBool("userLogin", true);
                    _authService.createEmailAndPassword(_email.text,
                        _password.text, _name.text, _userName.text, context);
                  }
                }),
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
    );
  }
}
