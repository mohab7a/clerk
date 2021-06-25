import 'package:clerk/modules/home_screen/home_screen.dart';
import 'package:clerk/shared/cubit/cubit.dart';
import 'package:clerk/shared/cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../shared/constants.dart';

class HomeLayout extends StatefulWidget {
  static String id = "NavBarScreen";
  int selectedIndex = 0;
  HomeLayout({this.selectedIndex});

  @override
  _HomeLayoutState createState() => _HomeLayoutState();
}

class _HomeLayoutState extends State<HomeLayout> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        AppCubit cubit = AppCubit.get(context);
        return Scaffold(
          backgroundColor: kBackgroundColor,
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            backgroundColor: kBackgroundColor,
            elevation: 0,
            title: GestureDetector(
              onTap: () {
                Navigator.pushReplacementNamed(context, HomeScreen.id);
              },
              child: Image.asset(
                "assets/images/clerk logo.png",
                width: MediaQuery.of(context).size.width * .25,
              ),
            ),
            automaticallyImplyLeading: true,
            centerTitle: true,
          ),
          body: IndexedStack(
            children: cubit.screens,
            index: cubit.selectedIndex,
          ),
          bottomNavigationBar: Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 5,
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16.0),
                topRight: Radius.circular(16.0),
              ),
              child: BottomNavigationBar(
                backgroundColor: Colors.white,
                elevation: 0,
                onTap: (value) {
                  cubit.changeNavBar(value);
                },
                currentIndex: cubit.selectedIndex,
                items: [
                  BottomNavigationBarItem(
                      icon: Icon(Icons.fact_check_outlined),
                      title: Text("Error Correction", textScaleFactor: 0.8)),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.translate_outlined),
                    title: Text(
                      "Translation",
                      textScaleFactor: 0.8,
                    ),
                  ),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.article_outlined),
                      title: Text(
                        "Summarization",
                        textScaleFactor: 0.8,
                      )),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.camera_alt_outlined),
                      title: Text(
                        "Text Extraction",
                        textScaleFactor: 0.8,
                      )),
                ],
                selectedItemColor: kPrimaryColor,
                unselectedItemColor: Color(0xFF8E8E8E),
                type: BottomNavigationBarType.fixed,
              ),
            ),
          ),
        );
      },
    );
  }
}
