import 'package:clerk/view/components/output_widget.dart';
import 'package:clerk/view/components/upload_file_widget.dart';
import 'package:clerk/view_model/text_detection_api.dart';
import 'package:flutter/material.dart';
import '../../../constants.dart';

class ErrorCorrectionScreen extends StatefulWidget {
  @override
  _ErrorCorrectionScreenState createState() => _ErrorCorrectionScreenState();
}

class _ErrorCorrectionScreenState extends State<ErrorCorrectionScreen> {
  TextEditingController inputFieldController = TextEditingController();
  TextEditingController outputFieldController = TextEditingController();
  String inputText = '';
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    inputFieldController.dispose();
    outputFieldController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return NotificationListener<OverscrollIndicatorNotification>(
      onNotification: (overScroll) {
        overScroll.disallowGlow();
        return;
      },
      child: FutureBuilder(
          future: gec(text: inputFieldController.text),
          builder: (context, snapshot) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.01,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    margin: EdgeInsets.only(
                      left: 20,
                      right: 20,
                      bottom: 20,
                    ),
                    decoration: kCustomBoxDecoration,
                    child: Stack(
                      children: [
                        TextFormField(
                          controller: inputFieldController,
                          onChanged: (text) {
                            inputText = text;
                            gecText(snapshot);
                            if (inputText.length == 0) {
                              inputFieldController.clear();
                              outputFieldController.clear();
                            }
                          },
                          maxLines: null,
                          minLines: 12,
                          showCursor: true,
                          cursorColor: kPrimaryColor,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              hintText: 'Enter Text Here'),
                        ),
                        UploadFileWidget(
                          controller: inputFieldController,
                        )
                      ],
                    ),
                  ),
                  OutPutWidget(outputFieldController: outputFieldController),
                ],
              ),
            );
          }),
    );
  }

  void gecText(AsyncSnapshot snapshot) {
    setState(() {
      gec(
        text: inputFieldController.text,
      );
      outputFieldController.text = snapshot.data["Output: "];
    });
  }
}
