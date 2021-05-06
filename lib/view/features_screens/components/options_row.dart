import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:share/share.dart';

import '../../../constants.dart';

class OptionsRow extends StatefulWidget {
  OptionsRow({Key key, this.text, this.controller});

  final String text;
  TextEditingController controller = TextEditingController();

  @override
  _OptionsRowState createState() => _OptionsRowState();
}

class _OptionsRowState extends State<OptionsRow> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          IconButton(
            icon: Icon(
              Icons.copy,
              color: kPrimaryColor,
            ),
            onPressed: () {
              copyToClipboard(context);
            },
          ),
          IconButton(
            icon: Icon(
              Icons.bookmark_border_outlined,
              color: kPrimaryColor,
            ),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(
              Icons.share_outlined,
              color: kPrimaryColor,
            ),
            onPressed: () {
              Share.share(widget.text);
            },
          ),
        ],
      ),
    );
  }

  void copyToClipboard(context) {
    if (widget.text.trim() != '') {
      FlutterClipboard.copy(widget.text);
    }
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor: kBackgroundColor,
      duration: Duration(seconds: 2),
      content: Text(
        "Text Copied",
        style: TextStyle(color: kPrimaryColor),
      ),
    ));
  }
}
