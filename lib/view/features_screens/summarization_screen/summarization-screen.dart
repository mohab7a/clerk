import 'package:clerk/view/features_screens/components/options_row.dart';
import 'package:flutter/material.dart';
import '../../../constants.dart';

class SummarizationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return NotificationListener<OverscrollIndicatorNotification>(
      onNotification: (overScroll){
        overScroll.disallowGlow();
        return;
      },
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: MediaQuery.of(context).size.height*0.01,),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
              margin: EdgeInsets.only(left: 20, right: 20, bottom: 20,),
              decoration: kCustomBoxDecoration,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextField(
                    maxLines: null,
                    minLines: 11,
                    showCursor: true,
                    cursorColor: kPrimaryColor,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        hintText: 'Enter Text Here'),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
              margin: EdgeInsets.only(left: 20, right: 20, bottom: 20,),
              decoration: kCustomBoxDecoration,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextField(
                    readOnly: true,
                    maxLines: null,
                    minLines: 10,
                    showCursor: false,
                    cursorColor: kPrimaryColor,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        hintText: 'Your Output '),
                  ),
                  OptionsRow(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
