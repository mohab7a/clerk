import 'package:clerk/view/auth_screens/signin_screens/components/Custom_form_field.dart';
import 'package:clerk/view_model/Provider/FirebaseProvider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../../constants.dart';

Future newPasswordDialog(BuildContext context, FireStoreProvider provider) {
  TextEditingController _password = TextEditingController();
  TextEditingController _newPassword = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  FirebaseAuth _auth = FirebaseAuth.instance;
  return showDialog(
      context: context,
      builder: (context) => AlertDialog(
            title: Text(
              "New Password",
              style: TextStyle(color: kPrimaryColor),
            ),
            backgroundColor: kDialogBoxColor,
            content: Form(
              key: _formKey,
              child: Column(
                children: [
                  CustomFormField(
                    hintText: "Enter Old Password",
                    controller: _password,
                    secure: true,
                    validator: (value) {
                      if (value != provider.data["password"])
                        return "Please enter Old password";
                    },
                  ),
                  SizedBox(height: 5),
                  CustomFormField(
                    hintText: "Enter new password",
                    controller: _newPassword,
                    secure: true,
                    validator: (value) {
                      if (value.isEmpty || value.length > 8)
                        return "Please Enter Strong Password";
                    },
                  ),
                  SizedBox(height: 5),
                  CustomFormField(
                    hintText: "Confirm new password",
                    secure: true,
                    validator: (value) {
                      if (value.isEmpty || value != _newPassword.text)
                        return "Password don't match";
                    },
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text("Cancel")),
              TextButton(
                  onPressed: () {
                    if (_formKey.currentState.validate()) {
                      _auth.currentUser.updatePassword(_newPassword.text);
                      provider.updateData(
                          key: "password", value: _newPassword.text);
                      Navigator.pop(context);
                    }
                  },
                  child: Text("Save"))
            ],
          ));
}
