import 'dart:async';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

import '../../constants.dart';

class UploadFileWidget extends StatefulWidget {

  final TextEditingController controller;

  const UploadFileWidget({Key key, this.controller,}) : super(key: key);
  @override
  _UploadFileWidgetState createState() => _UploadFileWidgetState();

}

class _UploadFileWidgetState extends State<UploadFileWidget> {

  @override
  void initState() {
    super.initState();
  }

@override
  Widget build(BuildContext context) {
      return Positioned(
      right: 0,
      top: 0,
      child: IconButton(
          icon: widget.controller.text.length == 0
              ? Icon(
            Icons.upload_file,
            color: kPrimaryColor,
          )
              : Icon(null),
          onPressed: () {
            setState(() {
              readText();
            });
          }),
    );
  }
Future readText() async {
    FilePickerResult file = await FilePicker.platform.pickFiles();
    String text = await File(file.files.single.path).readAsString();
    widget.controller.text = text;
}
}
