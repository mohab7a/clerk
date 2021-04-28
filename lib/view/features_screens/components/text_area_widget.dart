import 'package:clerk/constants.dart';
import 'package:flutter/material.dart';

class TextAreaWidget extends StatelessWidget {
  final String text;
  final VoidCallback onClickedCopy;

  const TextAreaWidget({
    @required this.text,
    @required this.onClickedCopy,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Row(
    children: [
      Expanded(
        child: Container(
          margin:  EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 20),
          padding: EdgeInsets.all(8),
          height: 400,
          decoration: kCustomBoxDecoration,
          alignment: Alignment.center,
          child: SelectableText(
            text.isEmpty ? 'Scan an Image to get text' : text,
            textAlign: TextAlign.center,
          ),
        ),
      ),
      // const SizedBox(width: 8),
      // IconButton(
      //   icon: Icon(Icons.copy, color: Colors.black),
      //   color: Colors.grey[200],
      //   onPressed: onClickedCopy,
      // ),
    ],
  );
}