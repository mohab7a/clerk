import 'package:clerk/view/error_correction_screen/error_correction_screen.dart';
import 'package:clerk/view/home_screen/home_screen.dart';
import 'package:clerk/view/summarization_screen/summarization-screen.dart';
import 'package:clerk/view/text_extraction_screen/text_extraction_screen.dart';
import 'package:clerk/view/translation_screen/translation_screen.dart';
import 'package:flutter/material.dart';
import '../constants.dart';

class NavigationBar extends StatefulWidget {
  static String id = "NavBarScreen";
  NavigationBar(this.selectedItem);
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
    List<Widget> screens = [];
    screens = <Widget>[
      ErrorCorrectionScreen(),
      TranslationScreen(),
      SummarizationScreen(),
      TextExtractionScreen(),
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: kBackgroundColor,
        elevation: 0,
        title:GestureDetector(
            child: Image.asset("assets/images/clerk logo.png",width: MediaQuery.of(context).size.width*.25,),
            onTap: () {
              Navigator.pushReplacementNamed(context, HomeScreen.id);
            },
        ),
        automaticallyImplyLeading: true,
        centerTitle: true,
      ),
      body: //SizedBox.expand(child: child),
      screens[widget.selectedItem],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [BoxShadow(
            color: Colors.black12,
            spreadRadius: 5,
            blurRadius: 7,
          )],
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
              BottomNavigationBarItem(icon: Icon(Icons.gesture),
                  title: Text("Error Correction",textScaleFactor: 0.9,)),
              BottomNavigationBarItem(
                  icon: Icon(Icons.translate),
                  title: Text("Translation", textScaleFactor: 0.9,),),
              BottomNavigationBarItem(
                  icon: Icon(Icons.gesture),
                  title: Text(
                    "Summarization", textScaleFactor: 0.9,
                  )),
              BottomNavigationBarItem(
                  icon: Icon(Icons.text_fields),
                  title: Text("Text Extraction", textScaleFactor: 0.9,)),
            ],
            selectedItemColor: kPrimaryColor,
            unselectedItemColor: Color(0xFF8E8E8E),
           //backgroundColor: Colors.black,
            type: BottomNavigationBarType.fixed,

          ),
        ),
      ),
    );
  }
}
