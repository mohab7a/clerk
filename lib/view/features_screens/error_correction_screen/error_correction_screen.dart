
import 'package:clerk/view/components/upload_file_widget.dart';
import 'package:flutter/material.dart';
import '../../../constants.dart';
import '../../components/options_row.dart';

class ErrorCorrectionScreen extends StatefulWidget {
  @override
  _ErrorCorrectionScreenState createState() => _ErrorCorrectionScreenState();
}

class _ErrorCorrectionScreenState extends State<ErrorCorrectionScreen> {

  TextEditingController editorFieldController = TextEditingController();
  String inputText = '';

  @override
  void dispose() {
    editorFieldController.dispose();
    super.dispose();
  }

  @override
  // ignore: must_call_super
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        color: kBackgroundColor,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          margin: EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 20),
          decoration: kCustomBoxDecoration,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Stack(
                children: [
                  TextField(
                    controller: editorFieldController,
                    onChanged: (text) {
                      setState(() {
                        inputText = text;
                        if(inputText.length == 0){
                          editorFieldController.clear();
                        }
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
                  UploadFileWidget(controller: editorFieldController,)
                ],
              ),
              OptionsRow(text: editorFieldController.text),
            ],
          ),
        ),
      ),
    );
  }
}


