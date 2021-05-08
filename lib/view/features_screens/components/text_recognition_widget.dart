import 'dart:io';
import 'package:clerk/constants.dart';
import 'package:clerk/view/features_screens/components/output_widget.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../../view_model/firebase_ml_text_recognition.dart';
import 'controls_widget.dart';

class TextRecognitionWidget extends StatefulWidget {
  @override
  _TextRecognitionWidgetState createState() => _TextRecognitionWidgetState();
}

class _TextRecognitionWidgetState extends State<TextRecognitionWidget> {
  String text = '';
  File image;
  TextEditingController outputFieldController = TextEditingController();

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
           outputFieldController.text != null ? OutPutWidget(outputFieldController: outputFieldController): null,
        ],
      );

  Widget buildImage() => Padding(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Container(
          height: MediaQuery.of(context).size.height * 0.26 ,
          width: MediaQuery.of(context).size.width - 64,
          child: image != null
              ? Image.file(
                  image,
                )
              : Icon(Icons.photo, size: 120, color: kPrimaryColor),
        ),
      );

  Future pickImage() async {
    final file = await ImagePicker().getImage(source: ImageSource.gallery);
    setImage(File(file.path));
  }

  Future scanText() async {
    showDialog(
      builder: (context) => Center(child: kLoadingCircle,),
      context: context,
    );

    // final text = await FirebaseMLApi.recogniseText(image);
    outputFieldController.text = await FirebaseMLApi.recogniseText(image);
    setText( outputFieldController.text);
    Navigator.of(context).pop();
  }

  void clear() {
    setState(() {
      outputFieldController.text = '';
    });
    setImage(null);
    setText('');
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
