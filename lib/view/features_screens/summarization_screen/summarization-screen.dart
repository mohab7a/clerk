import 'package:clerk/view/features_screens/components/options_row.dart';
import 'package:clerk/view_model/summarization_api.dart';
import 'package:flutter/material.dart';
import '../../../constants.dart';

class SummarizationScreen extends StatefulWidget {
  @override
  _SummarizationScreenState createState() => _SummarizationScreenState();
}

class _SummarizationScreenState extends State<SummarizationScreen> {
  TextEditingController inputField = TextEditingController();
  TextEditingController outputField = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    inputField.dispose();
    outputField.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return NotificationListener<OverscrollIndicatorNotification>(
      onNotification: (overScroll) {
        overScroll.disallowGlow();
        return;
      },
      child: FutureBuilder(
          future: summarize(text: inputField.text, sentences: 5),
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
                              summarize(text: inputField.text, sentences: 5);
                              outputField.text = snapshot.data["summary"];
                            });
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
                        OptionsRow(
                          text: outputField.text,
                        ),
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
