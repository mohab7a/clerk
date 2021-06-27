import 'package:clerk/shared/components/defaults.dart';
import 'package:clerk/shared/cubit/cubit.dart';
import 'package:clerk/shared/cubit/states.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../../shared/constants.dart';

class ErrorCorrectionScreen extends StatefulWidget {
  @override
  _ErrorCorrectionScreenState createState() => _ErrorCorrectionScreenState();
}

class _ErrorCorrectionScreenState extends State<ErrorCorrectionScreen> {
  TextEditingController inputFieldController = TextEditingController();
  TextEditingController outputFieldController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return NotificationListener<OverscrollIndicatorNotification>(
        onNotification: (overScroll) {
          overScroll.disallowGlow();
          return;
        },
        child: BlocConsumer<AppCubit, AppStates>(
          listener: (context, state) {
            if (state is TextCorrectionErrorState) {
              customSnackBar(
                  context: context, text: "Server sleep ....Zzzzzzz");
            } else if (state is TextCorrectionSuccessState) {
              outputFieldController.text =
                  AppCubit.get(context).textCorrectionModel.output;
            }
          },
          builder: (context, state) {
            return ConditionalBuilder(
              condition: true,
              builder: (context) => SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.01,
                    ),
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 10),
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
                              outputFieldController.addListener(() {
                                if (inputFieldController.text.isEmpty)
                                  outputFieldController.text = "";
                              });
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
                              controller: inputFieldController,
                              context: context),
                          submitButton(
                              context: context,
                              controller: inputFieldController,
                              function: () {
                                AppCubit.get(context)
                                    .textCorrection(inputFieldController.text);
                              })
                        ],
                      ),
                    ),
                    if (state is TextCorrectionLoadingState)
                      Column(
                        children: [
                          SpinKitThreeBounce(
                            color: kSecondaryColor,
                            size: 30,
                          ),
                        ],
                      ),
                    outputWidget(outputFieldController: outputFieldController),
                  ],
                ),
              ),
              fallback: (context) => Center(
                child: kLoadingCircle,
              ),
            );
          },
        ));
  }
}
