import 'package:flutter/material.dart';

import '../../../constants.dart';

class OptionsRow extends StatelessWidget {
  const OptionsRow({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
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
    );
  }
}