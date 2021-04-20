import 'package:flutter/material.dart';

import '../../../constants.dart';

class HomeCard extends StatelessWidget {
  const HomeCard({
    Key key,
    @required this.size,
    this.vector,
    this.text,
    this.onPressed,
  }) : super(key: key);

  final Size size;
  final String vector, text;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        margin: EdgeInsets.only(bottom: 25),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              spreadRadius: 5,
              blurRadius: 7,
            )
          ],
        ),
        width: double.infinity,
        height: size.height * 0.15,
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
