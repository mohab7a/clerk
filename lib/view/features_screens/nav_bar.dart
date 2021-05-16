import 'package:clerk/view/features_screens/error_correction_screen/error_correction_screen.dart';
import 'package:clerk/view/home_screen/home_screen.dart';
import 'package:clerk/view/features_screens/summarization_screen/summarization-screen.dart';
import 'package:clerk/view/features_screens/text_extraction_screen/text_extraction_screen.dart';
import 'package:clerk/view/features_screens/translation_screen/translation_screen.dart';
import 'package:flutter/material.dart';
import '../../constants.dart';
import 'error_correction_screen/error_correction_screen.dart';

// ignore: must_be_immutable
class NavigationBar extends StatefulWidget {
  static String id = "NavBarScreen";
  NavigationBar([this.selectedItem]);
  int selectedItem = 0;
  @override
  _NavigationBarState createState() => _NavigationBarState();
}

class _NavigationBarState extends State<NavigationBar> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> screens = [
      ErrorCorrectionScreen(),
      TranslationScreen(),
      SummarizationScreen(),
      TextExtractionScreen(),
    ];

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
        children: screens,
        index: widget.selectedItem,
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
            onTap: (newIndex) => setState(() => widget.selectedItem = newIndex),
            currentIndex: widget.selectedItem,
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
  }
}
