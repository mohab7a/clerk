import 'package:clerk/view/features_screens/components/options_row.dart';
import 'package:clerk/view_model/translation_api.dart';
import 'package:flutter/material.dart';
import '../../../constants.dart';

class TranslationScreen extends StatefulWidget {
  @override
  _TranslationScreenState createState() => _TranslationScreenState();
}

class _TranslationScreenState extends State<TranslationScreen> {
  TextEditingController inputField = TextEditingController();
  TextEditingController outputField = TextEditingController();

  // @override
  // void didChangeDependencies() {
  //
  //   super.didChangeDependencies();
  // }
  @override
  Widget build(BuildContext context) {
    return NotificationListener<OverscrollIndicatorNotification>(
      onNotification: (overScroll) {
        overScroll.disallowGlow();
        return;
      },
      child: FutureBuilder(
          future: translate(text: inputField.text, toLanguage: 'ar'),
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
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextFormField(
                          controller: inputField,
                          onChanged: (value) {
                            setState(() {
                              translate(
                                  text: inputField.text, toLanguage: 'ar');
                              outputField.text = snapshot.data["data"]
                                  ["translations"][0]["translatedText"];
                            });
                          },
                          maxLines: null,
                          minLines: 11,
                          showCursor: true,
                          cursorColor: kPrimaryColor,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              hintText: 'Enter Text Here'),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    margin: EdgeInsets.only(
                      left: 20,
                      right: 20,
                      bottom: 20,
                    ),
                    decoration: kCustomBoxDecoration,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextFormField(
                          controller: outputField,
                          readOnly: true,
                          maxLines: null,
                          minLines: 10,
                          showCursor: false,
                          cursorColor: kPrimaryColor,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              hintText: 'Your Output '),
                        ),
                        OptionsRow(),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }),
    );
  }
}
