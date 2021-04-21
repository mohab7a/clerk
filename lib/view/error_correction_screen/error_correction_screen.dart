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
          borderRadius: BorderRadius.circular(25),
          boxShadow: [
            BoxShadow(
                color: Colors.black12,
                spreadRadius: 5,
                blurRadius: 7,
                offset: Offset(1, 3)),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextField(
              maxLines: 24,
              showCursor: true,
              cursorColor: kPrimaryColor,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  hintText: 'Enter Text Here'),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  IconButton(icon: Icon(Icons.copy,color: kPrimaryColor,),onPressed: (){},),
                  IconButton(icon: Icon(Icons.bookmark_border_outlined,color: kPrimaryColor,),onPressed:(){},),
                  IconButton(icon: Icon(Icons.share_outlined,color: kPrimaryColor,),onPressed:(){},),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
