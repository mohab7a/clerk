import 'package:clerk/constants.dart';
import 'package:clerk/view/profile_screen/profile_screen.dart';
import 'package:flutter/material.dart';
import '../nav_bar.dart';
import 'components/Home_card.dart';

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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Container(
              child: Column(
                children: [
                  HomeCard(
                    margin: EdgeInsets.only(bottom: 25),
                    size: size,
                    text: "Error Correction",
                    vector: "assets/images/Mask Group 10.png",
                    onPressed: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => NavigationBar(0)));
                    },
                  ),
                  HomeCard(
                    margin: EdgeInsets.only(bottom: 25),
                    size: size,
                    text: "Translation",
                    vector: "assets/images/Mask Group 8.png",
                    onPressed: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => NavigationBar(1)));
                    },
                  ),
                  HomeCard(
                    margin: EdgeInsets.only(bottom: 25),
                    size: size,
                    text: "Summarization",
                    vector: "assets/images/Mask Group 1.png",
                    onPressed: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => NavigationBar(2)));
                    },
                  ),
                  HomeCard(
                    size: size,
                    text: "Text Extraction",
                    vector: "assets/images/Mask Group 9.png",
                    onPressed: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => NavigationBar(3)));
                    },
                  ),
                ],
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
