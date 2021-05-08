import 'package:flutter/material.dart';

import '../../../../constants.dart';

void customSnackBar(context, text) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    backgroundColor: kBackgroundColor,
    duration: Duration(seconds: 2),
    content: Text(
      text,
      style: TextStyle(color: kPrimaryColor),
    ),
  ));
}
