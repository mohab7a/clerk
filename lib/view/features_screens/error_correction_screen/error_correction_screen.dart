import 'package:flutter/material.dart';
import '../../../constants.dart';
import '../components/options_row.dart';

class ErrorCorrectionScreen extends StatefulWidget {
  @override
  _ErrorCorrectionScreenState createState() => _ErrorCorrectionScreenState();
}

class _ErrorCorrectionScreenState extends State<ErrorCorrectionScreen> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  TextEditingController editorFieldController = TextEditingController();

  @override
  // ignore: must_call_super
  Widget build(BuildContext context) {
    return NotificationListener<OverscrollIndicatorNotification>(
      onNotification: (overScroll){
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

class TextEditorField extends StatelessWidget {
  const TextEditorField({
    @required this.editorFieldController,
  }) ;

  final TextEditingController editorFieldController;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      margin: EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 20),
      decoration:kCustomBoxDecoration,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextField(
            controller: editorFieldController,
            maxLines: null,
            minLines: 25,
            showCursor: true,
            cursorColor: kPrimaryColor,
            decoration: InputDecoration(
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                hintText: 'Enter Text Here'),
          ),
          OptionsRow(text: editorFieldController.text),
        ],
      ),
    );
  }
}


