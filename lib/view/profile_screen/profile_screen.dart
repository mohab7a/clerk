import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../constants.dart';

class ProfileScreen extends StatefulWidget {
  static String id = "Profile Screen";

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  Map<String, dynamic> data;
  FirebaseAuth _auth = FirebaseAuth.instance;
  Future getData() async {
    final DocumentReference document = FirebaseFirestore.instance
        .collection("Users")
        .doc(_auth.currentUser.email);
    await document.get().then((snapshot) async {
      setState(() {
        data = snapshot.data();
      });
    });
  }

  @override
  initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Icon(
            Icons.arrow_back,
            color: kPrimaryColor,
          ),
        ),
        elevation: 0,
        backgroundColor: kBackgroundColor,
        title: Text(
          "Profile",
          style: TextStyle(color: kPrimaryColor, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          width: double.infinity,
          child: Column(
            children: [
              Stack(
                children: [
                  CircleAvatar(
                    radius: 80,
                  ),
                  Positioned(
                    right: 10,
                    bottom: 0,
                    child: Container(
                        height: size.height * 0.08,
                        width: size.width * 0.09,
                        decoration: BoxDecoration(
                            color: kPrimaryColor, shape: BoxShape.circle),
                        child: Image.asset("assets/images/Group 17.png")),
                  ),
                ],
              ),
              Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      UserListTile(
                        size: size,
                        data: data,
                        leadingIcon: "assets/images/Icon awesome-user-alt.png",
                        titleName: "Name",
                        field: "name",
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      UserListTile(
                        size: size,
                        data: data,
                        leadingIcon: "assets/images/Icon material-email.png",
                        titleName: "Email",
                        field: "email",
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      UserListTile(
                        size: size,
                        data: data,
                        leadingIcon: "assets/images/Icon simple-email.png",
                        titleName: "Username",
                        field: "username",
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      UserListTile(
                        size: size,
                        data: data,
                        leadingIcon: "assets/images/Icon feather-lock.png",
                        titleName: "Password",
                        field: "password",
                      ),
                      ListTile(
                        leading: Image.asset(
                          "assets/images/Icon awesome-bookmark.png",
                          width: size.width * 0.06,
                        ),
                        title: Text("Saved"),
                      )
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }
}

class UserListTile extends StatelessWidget {
  const UserListTile({
    Key key,
    @required this.size,
    this.data,
    this.titleName,
    this.field,
    this.leadingIcon,
  }) : super(key: key);

  final Size size;
  final Map<String, dynamic> data;
  final String titleName, field, leadingIcon;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Image.asset(
        leadingIcon,
        width: size.width * 0.06,
      ),
      title: Text(titleName),
      subtitle: Text(data[field]),
      trailing: Image.asset("assets/images/Icon material-edit.png",
          width: size.width * 0.06),
    );
  }
}
