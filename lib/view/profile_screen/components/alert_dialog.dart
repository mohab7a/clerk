import 'package:clerk/view/auth_screens/signin_screens/components/Custom_form_field.dart';
import 'package:clerk/view/components/custom_actions_button.dart';
import 'package:clerk/view_model/Provider/FirebaseProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../constants.dart';

AlertDialog editAlertDialog(
    {context, String title, key, value, TextEditingController controller}) {
  final provider = Provider.of<FireStoreProvider>(context);
  return AlertDialog(
    title: Text(title),
    backgroundColor: kDialogBoxColor,
    content: CustomFormField(
      controller: controller,
      secure: false,
    ),
    actions: [
      CustomActionsButton(
        buttonColor: Colors.white,
        textColor: Colors.red,
        text: "Cancel",
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      CustomActionsButton(
        onPressed: () {
          provider.updateData(key: key, value: controller.text);
          Navigator.pop(context);
        },
        text: "Save",
        textColor: Colors.white,
        buttonColor: kPrimaryColor,
      )
    ],
  );
}
