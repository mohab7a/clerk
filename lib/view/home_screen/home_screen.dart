import 'package:clerk/constants.dart';
import 'package:clerk/view/profile_screen/profile_screen.dart';
import 'package:flutter/material.dart';

import '../nav_bar.dart';

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
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Container(
            child: Column(
              children: [
                HomeCard(
                  size: size,
                  text: "Error Correction",
                  vector: "assets/images/Mask Group 10.png",
                  onPressed: (){Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => NavigationBar(0)));},
                ),
                HomeCard(
                    size: size,
                    text: "Translation",
                    vector: "assets/images/Mask Group 8.png",
                    onPressed: (){Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => NavigationBar(1)));},
                ),
                HomeCard(
                    size: size,
                    text: "Summarization",
                    vector: "assets/images/Mask Group 1.png",
                    onPressed: (){Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => NavigationBar(2)));},
                ),
                HomeCard(
                    size: size,
                    text: "Text Extraction",
                    vector: "assets/images/Mask Group 9.png",
                    onPressed: (){Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => NavigationBar(3)));},

                ),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}

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
          boxShadow: [BoxShadow(
            color: Colors.black12,
            spreadRadius: 5,
            blurRadius: 7,
          )],
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
