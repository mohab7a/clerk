import 'package:clerk/view/auth_screens/signin_screens/components/Custom_form_field.dart';
import 'package:clerk/view/auth_screens/signin_screens/components/custom_Snackbar.dart';
import 'package:clerk/view/components/custom_actions_button.dart';
import 'package:clipboard/clipboard.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:share/share.dart';

import '../../../constants.dart';

class OptionsRow extends StatefulWidget {
  OptionsRow({Key key, this.text});

  final String text;

  @override
  _OptionsRowState createState() => _OptionsRowState();
}

class _OptionsRowState extends State<OptionsRow> {
  TextEditingController controller = TextEditingController();
  FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          IconButton(
            icon: Icon(
              Icons.copy,
              color: kPrimaryColor,
            ),
            onPressed: () {
              copyToClipboard(context);
            },
          ),
          IconButton(
            icon: Icon(
              Icons.bookmark_border_outlined,
              color: kPrimaryColor,
            ),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text("doc name"),
                  backgroundColor: kDialogBoxColor,
                  content: CustomFormField(
                    controller: controller,
                    secure: false,
                  ),
                  actions: [
                    CustomActionsButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      text: "Cancel",
                      buttonColor: Colors.white,
                      textColor: Colors.red,
                    ),
                    CustomActionsButton(
                      onPressed: () {
                        _firebaseFirestore
                            .collection("Users")
                            .doc(_auth.currentUser.email)
                            .collection("saved")
                            .doc(controller.text)
                            .set({"document": widget.text});
                        Navigator.pop(context);
                        customSnackBar(context, "Added To Saved");
                      },
                      text: "Save",
                      buttonColor: kPrimaryColor,
                      textColor: Colors.white,
                    )
                  ],
                ),
              );
            },
          ),
          IconButton(
            icon: Icon(
              Icons.share_outlined,
              color: kPrimaryColor,
            ),
            onPressed: () {
              Share.share(widget.text);
            },
          ),
        ],
      ),
    );
  }

  void copyToClipboard(context) {
    if (widget.text.trim() != '') {
      FlutterClipboard.copy(widget.text);
      customSnackBar(context, "text Copied");
    }
  }
}
