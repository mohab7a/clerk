import 'dart:io';

import 'package:clerk/view/components/upload_file_widget.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

import '../../constants.dart';
import 'options_row.dart';

class TextEditorField extends StatefulWidget {
  const TextEditorField({
    @required this.editorFieldController,
  });
  final TextEditingController editorFieldController;

  @override
  _TextEditorFieldState createState() => _TextEditorFieldState();
}

class _TextEditorFieldState extends State<TextEditorField> {
  String inputText = '';

  @override
  void initState() {
    // ignore: unnecessary_statements
    widget.editorFieldController.addListener(() {});
    super.initState();
  }

  @override
  void dispose() {
    widget.editorFieldController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      margin: EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 20),
      decoration: kCustomBoxDecoration,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Stack(
            children: [
              TextField(
                controller: widget.editorFieldController,
                onChanged: (text) {
                  setState(() {
                    inputText = text;
                  });
                },
                maxLines: null,
                minLines: 25,
                showCursor: true,
                cursorColor: kPrimaryColor,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    hintText: 'Enter Text Here'),
              ),
              UploadFileWidget(
                controller: widget.editorFieldController, text: inputText,)
            ],
          ),
          OptionsRow(text: widget.editorFieldController.text),
        ],
      ),
    );
  }
}
