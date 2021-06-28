import 'package:clerk/models/saved_doc_model.dart';
import 'package:clerk/shared/constants.dart';
import 'package:flutter/material.dart';

class DocumentScreen extends StatelessWidget {
  SavedDocModel model;
  DocumentScreen(this.model);
  static String id = "Doc Screen";
  @override
  Widget build(BuildContext context) {
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
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                model.docName,
                style: Theme.of(context)
                    .textTheme
                    .headline2
                    .copyWith(color: kPrimaryColor),
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                model.docContent,
                style: Theme.of(context)
                    .textTheme
                    .headline6
                    .copyWith(color: Colors.grey[700]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
