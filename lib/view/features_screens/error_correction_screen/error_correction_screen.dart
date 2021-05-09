import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import '../../../constants.dart';
import '../components/options_row.dart';

class ErrorCorrectionScreen extends StatefulWidget {
  @override
  _ErrorCorrectionScreenState createState() => _ErrorCorrectionScreenState();
}

class _ErrorCorrectionScreenState extends State<ErrorCorrectionScreen>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  TextEditingController editorFieldController = TextEditingController();
  @override
  // ignore: must_call_super
  Widget build(BuildContext context) {
    return NotificationListener<OverscrollIndicatorNotification>(
      onNotification: (overScroll) {
        overScroll.disallowGlow();
        return;
      },
      child: SingleChildScrollView(
        child: Container(
          color: kBackgroundColor,
          child: TextEditorField(editorFieldController: editorFieldController),
        ),
      ),
    );
  }
}

class TextEditorField extends StatefulWidget {
  const TextEditorField({
    @required this.editorFieldController,
  });

  final TextEditingController editorFieldController;

  @override
  _TextEditorFieldState createState() => _TextEditorFieldState();
}

class _TextEditorFieldState extends State<TextEditorField> {
  bool isFileUploaded = false;
  bool isTextEmpty = false;
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
                maxLines: null,
                minLines: 25,
                showCursor: true,
                cursorColor: kPrimaryColor,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    hintText: 'Enter Text Here'),
              ),
              Positioned(
                right: 0,
                top: 0,
                child: IconButton(
                    icon: isFileUploaded == false
                        ? Icon(
                            Icons.upload_file,
                            color: kPrimaryColor,
                          )
                        : Icon(null),
                    onPressed: () {
                      readText();
                    }),
              )
            ],
          ),
          OptionsRow(text: widget.editorFieldController.text),
        ],
      ),
    );
  }

  Future readText() async {
    setState(() async {
      FilePickerResult file = await FilePicker.platform.pickFiles();
      String text = await File(file.files.single.path).readAsString();
      widget.editorFieldController.text = text;
      setState(() {
        isFileUploaded = !isFileUploaded;
      });
    });
  }
}
