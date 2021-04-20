import 'package:flutter/material.dart';
import '../../constants.dart';

class ErrorCorrectionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: kBackgroundColor,
      child: Container(
        margin: EdgeInsets.only(left: 16, right: 16, top: 20,bottom: 50),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                spreadRadius: 5,
                blurRadius: 7,
                offset: Offset(1,3)
              ),
            ],
        ),
      ),
    );
  }
}
