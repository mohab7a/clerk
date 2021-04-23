import 'dart:io';
import 'package:clerk/view_model/Provider/FirebaseProvider.dart';
import 'package:clerk/view_model/authintication_service/firebase_service.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../constants.dart';
import 'components/alert_dialog.dart';
import 'components/profile_list_tile.dart';

class ProfileScreen extends StatefulWidget {
  static String id = "Profile Screen";

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  File _image; //here we gonna store our image.
  FireBaseService _service = FireBaseService();
  TextEditingController _name = TextEditingController();
  TextEditingController _userName = TextEditingController();
  TextEditingController _password = TextEditingController();

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    Provider.of<FireStoreProvider>(context).getData();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<FireStoreProvider>(context);
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: FutureBuilder(
            future: provider.getData(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return SingleChildScrollView(
                  child: SizedBox(
                    width: double.infinity,
                    child: Column(
                      children: [
                        Stack(
                          children: [
                            CircleAvatar(
                              radius: 80,
                              backgroundColor: kPrimaryColor,
                              backgroundImage: _image == null
                                  ? AssetImage(
                                      "assets/images/734189-middle.png")
                                  : FileImage(_image),
                            ),
                            Positioned(
                              right: 10,
                              bottom: 0,
                              child: GestureDetector(
                                onTap: () => getImage(),
                                child: Container(
                                    height: size.height * 0.08,
                                    width: size.width * 0.09,
                                    decoration: BoxDecoration(
                                        color: kPrimaryColor,
                                        shape: BoxShape.circle),
                                    child: Image.asset(
                                        "assets/images/Group 17.png")),
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            UserListTile(
                              size: size,
                              data: provider.data,
                              field: "name",
                              leadingIcon:
                                  "assets/images/Icon awesome-user-alt.png",
                              titleName: "Name",
                              trailingIcon:
                                  "assets/images/Icon material-edit.png",
                              press: () {
                                showDialog(
                                  context: context,
                                  builder: (context) => editAlertDialog(
                                      context: context,
                                      key: "name",
                                      title: "Enter Your Name",
                                      controller: _name),
                                );
                              },
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            UserListTile(
                              size: size,
                              data: provider.data,
                              leadingIcon:
                                  "assets/images/Icon material-email.png",
                              titleName: "Email",
                              field: "email",
                              trailingIcon: "",
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            UserListTile(
                              size: size,
                              data: provider.data,
                              field: "username",
                              leadingIcon:
                                  "assets/images/Icon simple-email.png",
                              titleName: "Username",
                              trailingIcon:
                                  "assets/images/Icon material-edit.png",
                              press: () {
                                showDialog(
                                  context: context,
                                  builder: (context) => editAlertDialog(
                                      context: context,
                                      key: "username",
                                      title: "Enter Your Username",
                                      controller: _userName),
                                );
                              },
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            UserListTile(
                                size: size,
                                data: provider.data,
                                leadingIcon:
                                    "assets/images/Icon feather-lock.png",
                                titleName: "Password",
                                field: "password",
                                trailingIcon:
                                    "assets/images/Icon material-edit.png",
                                press: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) => editAlertDialog(
                                        context: context,
                                        key: "password",
                                        title: "Enter Your New Password",
                                        controller: _password),
                                  );
                                }),
                            SizedBox(
                              height: 10,
                            ),
                            ListTile(
                              leading: Image.asset(
                                "assets/images/Icon awesome-bookmark.png",
                                width: size.width * 0.06,
                              ),
                              title: Text("Saved"),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            GestureDetector(
                              onTap: () async {
                                SharedPreferences prefs =
                                    await SharedPreferences.getInstance();
                                prefs.remove("userLogin");
                                _service.signOut(context);
                              },
                              child: ListTile(
                                leading: Icon(
                                  Icons.logout,
                                  size: 30,
                                  color: kPrimaryColor,
                                ),
                                title: Text("Log Out"),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              } else if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }
              return Text("No Data");
            }),
      ),
    );
  }

  final picker = ImagePicker();

  Future getImage() async {
    final pickedFile = await picker.getImage(
      source: ImageSource.gallery,
    );
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }
}
