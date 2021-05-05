import 'dart:io';
import 'package:clerk/constants.dart';
import 'package:clerk/view/features_screens/components/text_area_widget.dart';
import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../../firebase_ml_text_recognition.dart';
import 'controls_widget.dart';

class TextRecognitionWidget extends StatefulWidget {
  @override
  _TextRecognitionWidgetState createState() => _TextRecognitionWidgetState();
}

class _TextRecognitionWidgetState extends State<TextRecognitionWidget> {
  String text = '';
  File image;

  @override
  Widget build(BuildContext context) => Column(
        children: [
          buildImage(),
          ControlsWidget(
            onClickedPickImage: pickImage,
            onClickedScanText: scanText,
            onClickedClear: clear,
          ),
          SizedBox(height: 16),
          TextAreaWidget(
            text: text,
            // onClickedCopy: copyToClipboard,
          ),
        ],
      );

  Widget buildImage() => Padding(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Container(
          width: MediaQuery.of(context).size.width - 40,
          child: image != null
              ? Image.file(
                  image,
                )
              : Icon(Icons.photo, size: 80, color: kPrimaryColor),
        ),
      );

  Future pickImage() async {
    final file = await ImagePicker().getImage(source: ImageSource.gallery);
    setImage(File(file.path));
  }

  Future scanText() async {
    showDialog(
      builder: (context) => Center(
        child: CircularProgressIndicator(),
      ),
      context: context,
    );

    final text = await FirebaseMLApi.recogniseText(image);
    setText(text);
    Navigator.of(context).pop();
  }

  void clear() {
    setImage(null);
    setText('');
  }

  void copyToClipboard() {
    if (text.trim() != '') {
      FlutterClipboard.copy(text);
    }
  }

  void setImage(File newImage) {
    setState(() {
      image = newImage;
    });
  }

  void setText(String newText) {
    setState(() {
      text = newText;
    });
  }
}
