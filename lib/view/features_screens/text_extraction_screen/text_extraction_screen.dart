import 'package:clerk/view/components/text_recognition_widget.dart';
import 'package:flutter/material.dart';
import '../../../constants.dart';

class TextExtractionScreen extends StatefulWidget {
  @override
  _TextExtractionScreenState createState() => _TextExtractionScreenState();
}

class _TextExtractionScreenState extends State<TextExtractionScreen> {
  @override
  Widget build(BuildContext context) {
    return NotificationListener<OverscrollIndicatorNotification>(
      onNotification: (overScroll){
      overScroll.disallowGlow();
      return;
    },
      child: SingleChildScrollView(
        child: Container(
          color: kBackgroundColor,
          child: TextRecognitionWidget(),
        ),
      ),
    );
  }
}
