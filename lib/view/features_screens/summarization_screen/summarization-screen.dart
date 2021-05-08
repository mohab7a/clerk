import 'package:clerk/view/features_screens/components/options_row.dart';
import 'package:clerk/view/features_screens/components/output_widget.dart';
import 'package:clerk/view_model/summarization_api.dart';
import 'package:flutter/material.dart';
import '../../../constants.dart';

class SummarizationScreen extends StatefulWidget {
  @override
  _SummarizationScreenState createState() => _SummarizationScreenState();
}

class _SummarizationScreenState extends State<SummarizationScreen> {
  TextEditingController inputFieldController = TextEditingController();
  TextEditingController outputFieldController = TextEditingController();

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
          future: summarize(text: inputFieldController.text, sentences: 5),
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
                          controller: inputFieldController,
                          onChanged: (value) {
                            summmarizeText(snapshot);
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
                  OutPutWidget(outputFieldController: outputFieldController),
                ],
              ),
            );
          }),
    );
  }

  void summmarizeText(AsyncSnapshot snapshot) {
    setState(() {
      summarize(text: inputFieldController.text, sentences: 5);
      outputFieldController.text = snapshot.data["summary"];
    });
  }
}
