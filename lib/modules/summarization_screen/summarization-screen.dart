import 'package:clerk/shared/components/defaults.dart';
import 'package:clerk/shared/cubit/cubit.dart';
import 'package:clerk/shared/cubit/states.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../../shared/constants.dart';

class SummarizationScreen extends StatefulWidget {
  @override
  _SummarizationScreenState createState() => _SummarizationScreenState();
}

class _SummarizationScreenState extends State<SummarizationScreen> {
  final TextEditingController inputFieldController = TextEditingController();
  final TextEditingController outputFieldController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return NotificationListener<OverscrollIndicatorNotification>(
        onNotification: (overScroll) {
          overScroll.disallowGlow();
          return;
        },
        child: BlocConsumer<AppCubit, AppStates>(
          listener: (context, state) {
            if (state is SummarizeTextSuccessState) {
              outputFieldController.text =
                  AppCubit.get(context).summarizationModel.summary;
            }
            // if (state is SummarizeTextLoadingState) {
            //   showDialog(
            //       context: context,
            //       builder: (context) => AlertDialog(
            //             content: SpinKitThreeBounce(
            //               color: Colors.red,
            //             ),
            //           ));
            // }
          },
          builder: (context, state) {
            return ConditionalBuilder(
              condition: AppCubit.get(context).summarizationModel != null,
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
                            maxLines: null,
                            minLines: 12,
                            showCursor: true,
                            cursorColor: kPrimaryColor,
                            onChanged: (value) {
                              outputFieldController.addListener(() {
                                if (inputFieldController.text.isEmpty)
                                  outputFieldController.text = "";
                              });
                            },
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
                                AppCubit.get(context).summarizeText(
                                    text: inputFieldController.text);
                              })
                        ],
                      ),
                    ),
                    if (state is SummarizeTextLoadingState)
                      Column(
                        children: [
                          SpinKitThreeBounce(
                            color: kSecondaryColor,
                            size: 30,
                          ),
                        ],
                      ),
                    SizedBox(
                      height: 10,
                    ),
                    // Column(
                    //   children: [
                    //     SizedBox(
                    //       height: 5,
                    //     ),
                    //     LinearProgressIndicator(),
                    //     SizedBox(
                    //       height: 5,
                    //     ),
                    //   ],
                    // ),
                    outputWidget(outputFieldController: outputFieldController),
                  ],
                ),
              ),
              fallback: (context) => Center(child: kLoadingCircle),
            );
          },
        ));
  }
}
