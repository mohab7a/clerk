import 'package:clerk/models/saved_doc_model.dart';
import 'package:clerk/shared/constants.dart';
import 'package:clerk/models/user_model.dart';
import 'package:clerk/shared/cubit/cubit.dart';
import 'package:clerk/shared/cubit/states.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share/share.dart';

Widget customFormField(
        {bool isPassword,
        TextEditingController controller,
        Function validator,
        String hintText,
        Function suffixFunction,
        IconData suffix,
        TextInputType keyboardType}) =>
    TextFormField(
      enableSuggestions: true,
      cursorColor: kPrimaryColor,
      obscureText: isPassword,
      controller: controller,
      validator: validator,
      keyboardType: keyboardType,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.all(8),
          fillColor: Colors.white,
          filled: true,
          hintText: hintText,
          suffixIcon: InkWell(
            child: Icon(suffix),
            onTap: suffixFunction,
          ),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
              borderRadius: BorderRadius.circular(8)),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
              borderRadius: BorderRadius.circular(8)),
          errorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
              borderRadius: BorderRadius.circular(8)),
          focusedErrorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
              borderRadius: BorderRadius.circular(8))),
    );

void customSnackBar({BuildContext context, String text}) =>
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor: kBackgroundColor,
      duration: Duration(seconds: 2),
      content: Text(
        text,
        style: TextStyle(color: kPrimaryColor),
      ),
    ));

Widget defaultButton(
        {String text,
        Color color = kPrimaryColor,
        Function onPressed,
        double width = double.infinity,
        double height = 40,
        Color textColor = Colors.white}) =>
    GestureDetector(
      onTap: onPressed,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
            color: color, borderRadius: BorderRadius.circular(10)),
        child: Center(
          child: Text(
            text.toUpperCase(),
            style: TextStyle(fontSize: 14, color: textColor),
          ),
        ),
      ),
    );

Widget defaultSocialButton(
        {String text,
        Color color = Colors.white,
        double width = double.infinity,
        double height = 40,
        BuildContext context,
        Color textColor = kPrimaryColor}) =>
    Container(
      height: height,
      width: width,
      decoration:
          BoxDecoration(color: color, borderRadius: BorderRadius.circular(10)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            "assets/images/Google.png",
            width: MediaQuery.of(context).size.width * 0.06,
          ),
          SizedBox(width: MediaQuery.of(context).size.width * 0.02),
          Center(
            child: Text(
              text.toUpperCase(),
              style: TextStyle(fontSize: 14, color: textColor),
            ),
          )
        ],
      ),
    );

Future<dynamic> navigateToAndFinish({
  @required context,
  @required String page,
}) =>
    Navigator.pushNamedAndRemoveUntil(context, page, (route) => false);

Future<dynamic> navigateTo({@required context, @required String page}) =>
    Navigator.pushNamed(context, page);

Widget homeCard(
        {Size size,
        String vector,
        String text,
        Function onPressed,
        EdgeInsets margin}) =>
    GestureDetector(
      onTap: onPressed,
      child: Container(
        margin: margin,
        decoration: kCustomBoxDecoration,
        width: double.infinity,
        height: size.height * 0.16,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                text,
                style: TextStyle(
                    color: kPrimaryColor,
                    fontSize: 24,
                    fontWeight: FontWeight.w500),
              ),
              Image.asset(vector, width: size.width * 0.30)
            ],
          ),
        ),
      ),
    );

Widget userListTile(
        {String leadingIcon,
        Size size,
        String titleName,
        String subtitle,
        Function onPressed,
        String trailingIcon}) =>
    ListTile(
      leading: Image.asset(
        leadingIcon,
        width: size.width * 0.06,
      ),
      title: Text(titleName),
      subtitle: Text(subtitle),
      trailing: GestureDetector(
        onTap: onPressed,
        child: trailingIcon != null
            ? Image.asset(trailingIcon, width: size.width * 0.06)
            : Text(""),
      ),
    );

Future newPasswordDialog(BuildContext context, UserModel model) {
  TextEditingController _password = TextEditingController();
  TextEditingController _newPassword = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  FirebaseAuth _auth = FirebaseAuth.instance;
  return showDialog(
      context: context,
      builder: (context) => BlocConsumer<AppCubit, AppStates>(
            listener: (context, state) {},
            builder: (context, state) => AlertDialog(
                title: Text(
                  "New Password",
                  style: TextStyle(color: kPrimaryColor),
                ),
                backgroundColor: kDialogBoxColor,
                content: Form(
                  key: _formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        customFormField(
                          hintText: "Enter Old Password",
                          controller: _password,
                          isPassword: true,
                          validator: (value) {
                            if (value != model.password)
                              return "Please enter Old password";
                          },
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        customFormField(
                          hintText: "Enter new password",
                          controller: _newPassword,
                          isPassword: true,
                          validator: (value) {
                            if (value.isEmpty || value.length > 8)
                              return "Please Enter Strong Password";
                          },
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        customFormField(
                          hintText: "Confirm new password",
                          isPassword: true,
                          validator: (value) {
                            if (value.isEmpty || value != _newPassword.text)
                              return "Password don't match";
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                actions: [
                  customActionsButton(
                    buttonColor: Colors.white,
                    textColor: Colors.red,
                    text: "Cancel",
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  customActionsButton(
                    onPressed: () {
                      if (_formKey.currentState.validate()) {
                        _auth.currentUser.updatePassword(_newPassword.text);
                        AppCubit.get(context).updateUserData(
                            key: "password", value: _newPassword.text);
                        Navigator.pop(context);
                      }
                    },
                    buttonColor: kPrimaryColor,
                    text: "Save",
                    textColor: Colors.white,
                  )
                ]),
          ));
}

AlertDialog editAlertDialog(
    {BuildContext context,
    String title,
    String key,
    String value,
    TextEditingController controller}) {
  return AlertDialog(
    title: Text(title),
    backgroundColor: kDialogBoxColor,
    content: customFormField(
      controller: controller,
      isPassword: false,
    ),
    actions: [
      customActionsButton(
          buttonColor: Colors.white,
          textColor: Colors.red,
          text: "Cancel",
          onPressed: () {
            Navigator.pop(context);
          },
          context: context),
      customActionsButton(
          onPressed: () {
            AppCubit.get(context)
                .updateUserData(key: key, value: controller.text);
            Navigator.pop(context);
          },
          text: "Save",
          textColor: Colors.white,
          buttonColor: kPrimaryColor,
          context: context)
    ],
  );
}

Widget controlsWidget({
  VoidCallback onClickedPickImage,
  VoidCallback onClickedScanText,
  VoidCallback onClickedClear,
}) =>
    Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ElevatedButton(
          onPressed: onClickedPickImage,
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(kPrimaryColor)),
          child: Text('Pick Image'),
        ),
        //const SizedBox(width: 28),
        ElevatedButton(
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(kPrimaryColor)),
          onPressed: onClickedScanText,
          child: Text('Scan For Text'),
        ),
        //const SizedBox(width: 28),
        ElevatedButton(
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(kPrimaryColor)),
          onPressed: onClickedClear,
          child: Text('Clear'),
        )
      ],
    );

Widget customActionsButton(
        {Color textColor,
        Color buttonColor,
        String text,
        Function onPressed,
        BuildContext context}) =>
    Container(
      width: MediaQuery.of(context).size.width * 0.35,
      decoration: kCustomBoxDecoration.copyWith(color: buttonColor),
      child: TextButton(
          onPressed: onPressed,
          child: Text(
            text,
            style: TextStyle(color: textColor),
          )),
    );

Widget optionsRow({
  String text,
  BuildContext context,
}) =>
    BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          TextEditingController controller = TextEditingController();
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
                    AppCubit.get(context)
                        .copyToClipboard(context: context, text: text);
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
                        content: customFormField(
                          controller: controller,
                          isPassword: false,
                        ),
                        actions: [
                          customActionsButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              text: "Cancel",
                              buttonColor: Colors.white,
                              textColor: Colors.red,
                              context: context),
                          customActionsButton(
                            onPressed: () {
                              SavedDocModel model = SavedDocModel(
                                  docContent: text, docName: controller.text);
                              FirebaseFirestore.instance
                                  .collection("users")
                                  .doc(userId)
                                  .collection("saved")
                                  .doc(controller.text)
                                  .set(model.toMap());
                              Navigator.pop(context);
                              customSnackBar(
                                  context: context, text: "Added To Saved");
                            },
                            text: "Save",
                            buttonColor: kPrimaryColor,
                            textColor: Colors.white,
                            context: context,
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
                    if (text.trim() != '') Share.share(text);
                  },
                ),
              ],
            ),
          );
        });

Widget outputWidget(
        {TextEditingController outputFieldController,
        TextEditingController inputFieldController,
        BuildContext context}) =>
    Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      margin: EdgeInsets.only(
        left: 20,
        right: 20,
        bottom: 20,
      ),
      decoration: kCustomBoxDecoration,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextFormField(
            controller: outputFieldController,
            readOnly: true,
            maxLines: null,
            onChanged: (value) {
              if (inputFieldController.text.isEmpty)
                outputFieldController.text = "";
            },
            minLines: 10,
            showCursor: false,
            cursorColor: kPrimaryColor,
            decoration: InputDecoration(
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                hintText: 'Your Output '),
          ),
          optionsRow(text: outputFieldController.text, context: context),
        ],
      ),
    );

Widget uploadFile({TextEditingController controller, BuildContext context}) =>
    Positioned(
        right: 0,
        top: 0,
        child: controller.text.isEmpty
            ? IconButton(
                icon: Icon(AppCubit.get(context).uploadIcon),
                color: kPrimaryColor,
                onPressed: () {
                  AppCubit.get(context).convertFileIntoText(controller);
                })
            : IconButton(
                onPressed: () {},
                icon: Icon(null),
              ));

Widget submitButton(
        {TextEditingController controller,
        BuildContext context,
        Function function}) =>
    Positioned(
        right: 0,
        bottom: 0,
        child: controller.text.isNotEmpty
            ? defaultButton(
                height: 30, width: 70, onPressed: function, text: "submit")
            : Container());

Widget buildDivider({@required Color color}) => Container(
      height: 1,
      width: double.infinity,
      color: color,
    );
