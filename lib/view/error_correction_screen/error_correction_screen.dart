import 'package:flutter/material.dart';
import '../../constants.dart';

class ErrorCorrectionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: kBackgroundColor,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        margin: EdgeInsets.only(left: 16, right: 16, top: 20, bottom: 30),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
                color: Colors.black12,
                spreadRadius: 5,
                blurRadius: 7,
                offset: Offset(1, 3)),
          ],
        ),
        child: TextField(
          maxLines: 1000,
          showCursor: true,
          cursorColor: kPrimaryColor,
          decoration: InputDecoration(
              border: InputBorder.none,
              focusedBorder: InputBorder.none,
              hintText: 'Enter Text'),
        ),
      ),
    );
  }
}
