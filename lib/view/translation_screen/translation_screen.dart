import 'package:flutter/material.dart';

import '../../constants.dart';
class TranslationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: kBackgroundColor,
      child: Column(
        children: [
          SizedBox(height: MediaQuery.of(context).size.height*0.01,),
          Expanded(
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height*0.4 ,
              padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
              margin: EdgeInsets.only(left: 20, right: 20, bottom: 20,),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(25),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black12,
                      blurRadius: 7,
                      ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextField(
                    maxLines: 10,
                    showCursor: true,
                    cursorColor: kPrimaryColor,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        hintText: 'Enter Text Here'),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height*0.4 ,
              padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
              margin: EdgeInsets.only(left: 20, right: 20, bottom: 20,),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(25),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 7,
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(''),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        IconButton(icon: Icon(Icons.copy,color: kPrimaryColor,),onPressed: (){},),
                        IconButton(icon: Icon(Icons.bookmark_border_outlined,color: kPrimaryColor,),onPressed:(){},),
                        IconButton(icon: Icon(Icons.share_outlined,color: kPrimaryColor,),onPressed:(){},),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
