import 'package:clerk/constants.dart';
import 'package:clerk/view/auth_screens/signin_screens/components/custom_Snackbar.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SavedScreen extends StatefulWidget {
  const SavedScreen({Key key}) : super(key: key);
  static String id = "Saved Screen";
  @override
  _SavedScreenState createState() => _SavedScreenState();
}

class _SavedScreenState extends State<SavedScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        backgroundColor: kBackgroundColor,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back,
            color: kPrimaryColor,
          ),
        ),
        title: Text(
          'Saved Documents',
          style: TextStyle(color: kPrimaryColor, fontWeight: FontWeight.bold),
        ),
        elevation: 0,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('Users')
            .doc(FirebaseAuth.instance.currentUser.email)
            .collection('saved')
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: kLoadingCircle,
            );
          }
          return ListView.builder(
              itemCount: snapshot.data.size,
              itemBuilder: (ctx, index) {
                final doc = snapshot.data.docs[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical:5,horizontal: 12),
                  child: Container(
                    decoration: kCustomBoxDecoration.copyWith(color: kPrimaryColor),
                    child: Dismissible(
                      direction: DismissDirection.horizontal,
                      key: ValueKey<QueryDocumentSnapshot>(doc),
                      onDismissed: (DismissDirection direction) {
                        setState(() {
                          snapshot.data.docs[index].reference.delete();
                        });
                        customSnackBar(context, "Removed");
                      },
                      background: Container(
                        decoration: kCustomBoxDecoration.copyWith(color:kSecondaryColor ),
                        child: Icon(Icons.delete,color: Colors.white,),
                      ),
                      child: ListTile(
                        title: Text(snapshot.data.docs[index].id,style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                      ),
                    ),
                  ),
                );
              });
        },
      ),
    );
  }
}
