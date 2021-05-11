import 'package:clerk/view/components/output_widget.dart';
import 'package:clerk/view/components/upload_file_widget.dart';
import 'package:clerk/view_model/translation_api.dart';
import 'package:flutter/material.dart';
import '../../../constants.dart';

class TranslationScreen extends StatefulWidget {
  @override
  _TranslationScreenState createState() => _TranslationScreenState();
}

class _TranslationScreenState extends State<TranslationScreen> {
  TextEditingController inputFieldController = TextEditingController();
  TextEditingController outputFieldController = TextEditingController();
  Translate translate = Translate();
  String inputText = '';
  String outputText = '';
  @override

  @override
  void dispose() {
    super.dispose();
    inputFieldController.dispose();
    outputFieldController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: translate.translate(text: inputFieldController.text, toLanguage: 'ar'),
        builder: (context, snapshot) {
          return SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.01,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  margin: EdgeInsets.only(left: 20, right: 20, bottom: 20,),
                  decoration: kCustomBoxDecoration,
                  child: Stack(
                    children: [
                      TextFormField(
                        controller: inputFieldController,
                        onChanged: (text) {
                          inputText = text;
                          translateText(snapshot);
                          if(inputText.length == 0){
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
                      UploadFileWidget(controller: inputFieldController,),
                    ],
                  ),
                ),
                OutPutWidget(outputFieldController: outputFieldController),
              ],
            ),
          );
        });
  }

  void translateText(AsyncSnapshot snapshot) {
    setState(() {
      outputText = snapshot.data["data"]["translations"][0]["translatedText"];
      outputFieldController.text = outputText;
    });
  }
}
