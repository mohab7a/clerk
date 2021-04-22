import 'package:clerk/view/signin_screens/signin_screen.dart';
import 'package:clerk/view_model/Provider/FirebaseProvider.dart';
import 'package:flutter/material.dart';
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
                                child: Icon(Icons.person,size: 120,color: Colors.white,)
                            ),
                            Positioned(
                              right: 10,
                              bottom: 0,
                              child: Container(
                                  height: size.height * 0.08,
                                  width: size.width * 0.09,
                                  decoration: BoxDecoration(
                                      color: kPrimaryColor,
                                      shape: BoxShape.circle),
                                  child: Image.asset(
                                      "assets/images/Group 17.png")),
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
                                  builder: (context) => alert(
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
                                  builder: (context) => alert(
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
                                field: ("password"),
                                trailingIcon:
                                    "assets/images/Icon material-edit.png",
                                press: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) => alert(
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
                                await Navigator.pushNamedAndRemoveUntil(
                                    context, SignInScreen.id, (route) => false);
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
}
