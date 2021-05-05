import 'package:clerk/constants.dart';
import 'package:flutter/material.dart';

class CustomFormField extends StatelessWidget {
  const CustomFormField({
    Key key,
    this.hintText,
    this.validator,
    this.controller,
    this.secure,
  }) : super(key: key);
  final String hintText;
  final Function validator;
  final TextEditingController controller;
  final bool secure;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      enableSuggestions: true,
      cursorColor: kPrimaryColor,
      obscureText: secure,
      controller: controller,
      validator: validator,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.all(8),
          fillColor: Colors.white,
          filled: true,
          hintText: hintText,
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
  }
}
