import 'dart:io';

import 'package:clerk/view/components/text_editor_field.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import '../../../constants.dart';
import '../../components/options_row.dart';

class ErrorCorrectionScreen extends StatefulWidget {
  @override
  _ErrorCorrectionScreenState createState() => _ErrorCorrectionScreenState();
}

class _ErrorCorrectionScreenState extends State<ErrorCorrectionScreen>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  TextEditingController editorFieldController = TextEditingController();
  @override
  // ignore: must_call_super
  Widget build(BuildContext context) {
    return NotificationListener<OverscrollIndicatorNotification>(
      onNotification: (overScroll) {
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


