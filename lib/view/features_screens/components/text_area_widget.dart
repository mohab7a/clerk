import 'package:clerk/constants.dart';
import 'package:flutter/material.dart';

import 'options_row.dart';

class TextAreaWidget extends StatefulWidget {
  final String text;
  final VoidCallback onClickedCopy;

  const TextAreaWidget({
    @required this.text,
    @required this.onClickedCopy,
    Key key,
  }) : super(key: key);

  @override
  _TextAreaWidgetState createState() => _TextAreaWidgetState();
}

class _TextAreaWidgetState extends State<TextAreaWidget> {
  TextEditingController outputField = TextEditingController();

  @override
  Widget build(BuildContext context) => Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        margin: EdgeInsets.only(
          left: 20,
          right: 20,
          bottom: 20,
        ),
        height: MediaQuery.of(context).size.height * 0.5,
        decoration: kCustomBoxDecoration,
        alignment: Alignment.center,
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.4,
              child: SelectableText(
                widget.text.isEmpty ? '' : widget.text,
                textAlign: TextAlign.start,
                // textAlign: TextAlign.center,
              ),
            ),
            OptionsRow(
              text: widget.text,
            ),
          ],
        ),
      );
}
