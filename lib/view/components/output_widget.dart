import 'package:flutter/material.dart';

import '../../constants.dart';
import 'options_row.dart';

class OutPutWidget extends StatelessWidget {
  const OutPutWidget({
    @required this.outputFieldController,
  });

  final TextEditingController outputFieldController;

  @override
  Widget build(BuildContext context) {
    return Container(
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
            controller: outputFieldController,
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
            text: outputFieldController.text,
          ),
        ],
      ),
    );
  }
}