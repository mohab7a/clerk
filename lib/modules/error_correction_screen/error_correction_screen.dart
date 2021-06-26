
import 'package:clerk/shared/components/defaults.dart';
import 'package:clerk/shared/cubit/cubit.dart';
import 'package:clerk/shared/cubit/states.dart';
import 'package:clerk/shared/text_detection_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../shared/constants.dart';

class ErrorCorrectionScreen extends StatefulWidget {
  @override
  _ErrorCorrectionScreenState createState() => _ErrorCorrectionScreenState();
}

class _ErrorCorrectionScreenState extends State<ErrorCorrectionScreen> {
  TextEditingController inputFieldController = TextEditingController();
  TextEditingController outputFieldController = TextEditingController();
  String inputText = '';
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
      child: BlocConsumer<AppCubit,AppStates>(
        listener: (context, state) {
           if(state is TextCorrectionErrorState){
             customSnackBar(context: context,text: "Server sleep ....Zzzzzzz");
           }
          } ,
        builder:(context, state) {
          outputFieldController.text = AppCubit.get(context).textCorrectionModel.output;
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
                  child: Stack(
                    children: [
                      TextFormField(
                        controller: inputFieldController,
                        onChanged: (text) {
                          AppCubit.get(context).textCorrection(text);
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
                      uploadFile(
                          controller: inputFieldController, context: context)
                    ],
                  ),
                ),
                outputWidget(outputFieldController: outputFieldController),
              ],
            ),
          );
        } ,
      )
    );
  }

  void gecText(AsyncSnapshot snapshot) {
    setState(() {
      gec(
        text: inputFieldController.text,
      );
      outputFieldController.text = snapshot.data["Output: "];
    });
  }
}
