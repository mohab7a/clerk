import 'package:flutter/material.dart';
import '../../../constants.dart';
import '../components/options_row.dart';

class ErrorCorrectionScreen extends StatefulWidget {
  @override
  _ErrorCorrectionScreenState createState() => _ErrorCorrectionScreenState();
}

class _ErrorCorrectionScreenState extends State<ErrorCorrectionScreen> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  // ignore: must_call_super
  Widget build(BuildContext context) {
    return NotificationListener<OverscrollIndicatorNotification>(
      onNotification: (overScroll){
        overScroll.disallowGlow();
        return;
      },
      child: SingleChildScrollView(
        child: Container(
          color: kBackgroundColor,
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            margin: EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 20),
            decoration:kCustomBoxDecoration,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextField(
                  maxLines: null,
                  minLines: 25,
                  showCursor: true,
                  cursorColor: kPrimaryColor,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      hintText: 'Enter Text Here'),
                ),
                OptionsRow(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


