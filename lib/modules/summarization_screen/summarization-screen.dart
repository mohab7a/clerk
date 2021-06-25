import 'package:clerk/shared/components/defaults.dart';
import 'package:clerk/shared/cubit/cubit.dart';
import 'package:clerk/shared/cubit/states.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
          },
          builder: (context, state) {
            AppCubit cubit = AppCubit.get(context);
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
                            onChanged: (value) {
                              cubit.summarizeText(text: value);
                              outputFieldController.addListener(() {
                                if (inputFieldController.text.isEmpty)
                                  outputFieldController.text = "";
                              });
                            },
                            onFieldSubmitted: (value) {},
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
                        ],
                      ),
                    ),
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
