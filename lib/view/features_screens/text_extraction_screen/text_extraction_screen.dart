import 'package:clerk/view/features_screens/components/text_recognition_widget.dart';
import 'package:flutter/material.dart';
import '../../../constants.dart';

class TextExtractionScreen extends StatefulWidget {
  @override
  _TextExtractionScreenState createState() => _TextExtractionScreenState();
}

class _TextExtractionScreenState extends State<TextExtractionScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: kBackgroundColor,
      child: TextRecognitionWidget(),
    );
  }
}
