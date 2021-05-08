import 'package:clerk/constants.dart';
import 'package:clerk/view/profile_screen/profile_screen.dart';
import 'package:flutter/material.dart';

import 'components/Home_screen_body.dart';

class HomeScreen extends StatelessWidget {
  static String id = "Home Screen";
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: kBackgroundColor,
        leading: GestureDetector(
          onTap: () => Navigator.pushNamed(context, ProfileScreen.id),
          child: Icon(
            Icons.account_circle_rounded,
            color: kPrimaryColor,
            size: 30,
          ),
        ),
        title: Image.asset("assets/images/clerk header.png",
            width: size.width * 0.24),
        centerTitle: true,
      ),
      body: HomeScreenBody(size: size),
    );
  }
}
