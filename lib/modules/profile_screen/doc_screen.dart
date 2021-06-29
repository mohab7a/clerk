import 'package:clerk/models/saved_doc_model.dart';
import 'package:clerk/shared/components/defaults.dart';
import 'package:clerk/shared/constants.dart';
import 'package:flutter/material.dart';

class DocumentScreen extends StatelessWidget {
  final TextEditingController controller = TextEditingController();
  SavedDocModel model;
  DocumentScreen(this.model);
  static String id = "Doc Screen";
  @override
  Widget build(BuildContext context) {
    controller.text = model.docContent;
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        title: Text(
          model.docName,
          style: TextStyle(color: kPrimaryColor, fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back,
            color: kPrimaryColor,
          ),
        ),
        backgroundColor: kBackgroundColor,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 30,
              ),
              outputWidget(context: context, outputFieldController: controller)
            ],
          ),
        ),
      ),
    );
  }
}
