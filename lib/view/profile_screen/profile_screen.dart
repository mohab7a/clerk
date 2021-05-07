import 'dart:io';
import 'package:clerk/view/auth_screens/signin_screens/components/Custom_form_field.dart';
import 'package:clerk/view/profile_screen/saved_screen.dart';
import 'package:clerk/view_model/Provider/FirebaseProvider.dart';
import 'package:clerk/view_model/authintication_service/firebase_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../../constants.dart';
import 'components/alert_dialog.dart';
import 'components/profile_list_tile.dart';

class ProfileScreen extends StatefulWidget {
  static String id = "Profile Screen";

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  FirebaseAuth _auth = FirebaseAuth.instance;
  File _image; //here we gonna store our image.
  FireBaseService _service = FireBaseService();
  TextEditingController _name = TextEditingController();
  TextEditingController _userName = TextEditingController();
  TextEditingController _password = TextEditingController();
  TextEditingController _newPassword = TextEditingController();

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
                                backgroundImage: provider.data['userImage'] ==
                                        ""
                                    ? AssetImage(
                                        "assets/images/734189-middle.png")
                                    : NetworkImage(provider.data["userImage"])),
                            Positioned(
                              right: 10,
                              bottom: 0,
                              child: GestureDetector(
                                onTap: () => getImage().then((value) =>
                                    provider.firebaseStorage(
                                        image: _image, context: context)),
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
                                      builder: (context) => AlertDialog(
                                            title: Text(
                                              "New Password",
                                              style: TextStyle(
                                                  color: kPrimaryColor),
                                            ),
                                            backgroundColor: kDialogBoxColor,
                                            content: Form(
                                              key: _formKey,
                                              child: Column(
                                                children: [
                                                  CustomFormField(
                                                    hintText:
                                                        "Enter Old Password",
                                                    controller: _password,
                                                    secure: true,
                                                    validator: (value) {
                                                      if (value !=
                                                          provider
                                                              .data["password"])
                                                        return "Please enter Old password";
                                                    },
                                                  ),
                                                  SizedBox(height: 5),
                                                  CustomFormField(
                                                    hintText:
                                                        "Enter new password",
                                                    controller: _newPassword,
                                                    secure: true,
                                                    validator: (value) {
                                                      if (value.isEmpty ||
                                                          value.length > 8)
                                                        return "Please Enter Strong Password";
                                                    },
                                                  ),
                                                  SizedBox(height: 5),
                                                  CustomFormField(
                                                    hintText:
                                                        "Confirm new password",
                                                    secure: true,
                                                    validator: (value) {
                                                      if (value.isEmpty ||
                                                          value !=
                                                              _newPassword.text)
                                                        return "Password don't match";
                                                    },
                                                  ),
                                                ],
                                              ),
                                            ),
                                            actions: [
                                              TextButton(
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                  child: Text("Cancel")),
                                              TextButton(
                                                  onPressed: () {
                                                    if (_formKey.currentState
                                                        .validate()) {
                                                      _auth.currentUser
                                                          .updatePassword(
                                                              _newPassword
                                                                  .text);
                                                      provider.updateData(
                                                          key: "password",
                                                          value: _newPassword
                                                              .text);
                                                      Navigator.pop(context);
                                                    }
                                                  },
                                                  child: Text("Save"))
                                            ],
                                          ));
                                }),
                            SizedBox(
                              height: 10,
                            ),
                            GestureDetector(
                              onTap: (){Navigator.pushNamed(context, SavedScreen.id);},
                              child: ListTile(
                                leading: Image.asset(
                                  "assets/images/Icon awesome-bookmark.png",
                                  width: size.width * 0.06,
                                ),
                                title: Text("Saved"),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            GestureDetector(
                              onTap: () async {
                                // SharedPreferences prefs =
                                //     await SharedPreferences.getInstance();
                                // prefs
                                //     .remove("userLogin")
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
                return Center(
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(kPrimaryColor),
                ),
                );
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
