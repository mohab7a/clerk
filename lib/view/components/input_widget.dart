// import 'package:clerk/view/components/output_widget.dart';
// import 'package:clerk/view/components/upload_file_widget.dart';
// import 'package:flutter/material.dart';
// import '../../constants.dart';
//
// class InputWidget extends StatelessWidget {
//
//   const InputWidget({
//     Key key,
//     @required this.inputFieldController,
//     @required this.outputFieldController,
//     @required this.featureFunction,
//     @required this.text,
//   }) : super(key: key);
//
//   final TextEditingController inputFieldController;
//   final TextEditingController outputFieldController;
//   final Function featureFunction;
//   final String text;
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//       margin: EdgeInsets.only(
//         left: 20,
//         right: 20,
//         bottom: 20,
//       ),
//       decoration: kCustomBoxDecoration,
//       child: Stack(
//         children: [
//           TextFormField(
//             controller: inputFieldController,
//             onChanged: (text) {
//               String inputText = '';
//               inputText = text;
//               if(inputText.length == 0){
//                 inputFieldController.clear();
//                 outputFieldController.clear();
//               }
//               // ignore: unnecessary_statements
//               featureFunction ;
//             },
//             maxLines: null,
//             minLines: 12,
//             showCursor: true,
//             cursorColor: kPrimaryColor,
//             decoration: InputDecoration(
//                 border: InputBorder.none,
//                 focusedBorder: InputBorder.none,
//                 hintText: 'Enter Text Here'),
//           ),
//           UploadFileWidget(controller: inputFieldController,text: text,)
//         ],
//       ),
//     );
//   }
// }