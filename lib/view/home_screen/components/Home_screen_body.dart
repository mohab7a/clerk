import 'package:clerk/view/features_screens/nav_bar.dart';
import 'package:flutter/material.dart';

import 'Home_card.dart';

class HomeScreenBody extends StatelessWidget {
  const HomeScreenBody({
    Key key,
    @required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
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
    );
  }
}
