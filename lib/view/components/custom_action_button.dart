import 'package:flutter/material.dart';

import '../../constants.dart';

class CustomActionsButton extends StatelessWidget {
  const CustomActionsButton({
    Key key,
    this.textColor,
    this.buttonColor,
    this.text,
    this.onPressed,
  }) : super(key: key);
  final Color textColor, buttonColor;
  final String text;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.35,
      decoration: kCustomBoxDecoration.copyWith(color: buttonColor),
      child: TextButton(
          onPressed: onPressed,
          child: Text(
            text,
            style: TextStyle(color: textColor),
          )),
    );
  }
}
