import 'package:flutter/material.dart';

import '../../../constants.dart';

class HomeCard extends StatelessWidget {
  const HomeCard({
    Key key,
    @required this.size,
    this.vector,
    this.text,
    this.onPressed,
    this.margin,
  }) : super(key: key);

  final Size size;
  final String vector, text;
  final Function onPressed;
  final EdgeInsets margin;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        margin: margin,
        decoration: kCustomBoxDecoration,
        width: double.infinity,
        height: size.height * 0.16,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                text,
                style: TextStyle(
                    color: kPrimaryColor,
                    fontSize: 24,
                    fontWeight: FontWeight.w500),
              ),
              Image.asset(vector, width: size.width * 0.30)
            ],
          ),
        ),
      ),
    );
  }
}
