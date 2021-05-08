import 'package:clerk/constants.dart';
import 'package:flutter/material.dart';

class ControlsWidget extends StatelessWidget {
  final VoidCallback onClickedPickImage;
  final VoidCallback onClickedScanText;
  final VoidCallback onClickedClear;

  const ControlsWidget({
    @required this.onClickedPickImage,
    @required this.onClickedScanText,
    @required this.onClickedClear,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,

    children: [
      ElevatedButton(
        onPressed: onClickedPickImage,
        style: ButtonStyle(backgroundColor: MaterialStateProperty. all<Color>(kPrimaryColor) ),
        child: Text('Pick Image'),
      ),
      //const SizedBox(width: 28),
      ElevatedButton(
        style: ButtonStyle(backgroundColor: MaterialStateProperty. all<Color>(kPrimaryColor) ),
        onPressed: onClickedScanText,
        child: Text('Scan For Text'),
      ),
      //const SizedBox(width: 28),
      ElevatedButton(
        style: ButtonStyle(backgroundColor: MaterialStateProperty. all<Color>(kPrimaryColor) ),
        onPressed: onClickedClear,
        child: Text('Clear'),
      )
    ],
  );
}