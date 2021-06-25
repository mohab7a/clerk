import 'package:clerk/modules/profile_screen/profile_screen.dart';
import 'package:clerk/shared/components/defaults.dart';
import 'package:clerk/shared/constants.dart';
import 'package:clerk/shared/cubit/cubit.dart';
import 'package:clerk/layout/home_layout.dart';
import 'package:flutter/material.dart';

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
            onTap: () {
              AppCubit.get(context).getUserData();
              Navigator.pushNamed(context, ProfileScreen.id);
            },
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
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Container(
                child: Column(
                  children: [
                    homeCard(
                      margin: EdgeInsets.only(bottom: 25),
                      size: size,
                      text: "Error Correction",
                      vector: "assets/images/Mask Group 10.png",
                      onPressed: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => HomeLayout(
                                      selectedIndex: AppCubit.get(context)
                                          .selectedIndex = 0,
                                    )));
                      },
                    ),
                    homeCard(
                      margin: EdgeInsets.only(bottom: 25),
                      size: size,
                      text: "Translation",
                      vector: "assets/images/Mask Group 8.png",
                      onPressed: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => HomeLayout(
                                      selectedIndex: AppCubit.get(context)
                                          .selectedIndex = 1,
                                    )));
                      },
                    ),
                    homeCard(
                      margin: EdgeInsets.only(bottom: 25),
                      size: size,
                      text: "Summarization",
                      vector: "assets/images/Mask Group 1.png",
                      onPressed: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => HomeLayout(
                                      selectedIndex: AppCubit.get(context)
                                          .selectedIndex = 2,
                                    )));
                      },
                    ),
                    homeCard(
                      size: size,
                      text: "Text Extraction",
                      vector: "assets/images/Mask Group 9.png",
                      onPressed: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => HomeLayout(
                                      selectedIndex: AppCubit.get(context)
                                          .selectedIndex = 3,
                                    )));
                      },
                    ),
                  ],
                ),
              ),
            ]),
          ),
        ));
  }
}
