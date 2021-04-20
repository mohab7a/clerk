import 'package:clerk/view/signin_screens/components/Custom_form_field.dart';
import 'package:clerk/view/signin_screens/signin_screen.dart';
import 'package:clerk/view_model/Provider/FirebaseProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../constants.dart';
import 'components/profile_list_tile.dart';

class ProfileScreen extends StatefulWidget {
  static String id = "Profile Screen";

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    Provider.of<FireStoreProvider>(context).getData();
    super.didChangeDependencies();
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
            child: Column(children: [
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
                  child: FutureBuilder(
                      future: Provider.of<FireStoreProvider>(context).getData(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.done) {
                          return Column(
                            children: [
                              UserListTile(
                                size: size,
                                data: Provider.of<FireStoreProvider>(context)
                                    .data['name'],
                                leadingIcon:
                                    "assets/images/Icon awesome-user-alt.png",
                                titleName: "Name",
                                trailingIcon:
                                    "assets/images/Icon material-edit.png",
                                press: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) => alert(context),
                                  );
                                },
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              UserListTile(
                                size: size,
                                data: Provider.of<FireStoreProvider>(context)
                                    .data["email"],
                                leadingIcon:
                                    "assets/images/Icon material-email.png",
                                titleName: "Email",
                                trailingIcon: "",
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              UserListTile(
                                size: size,
                                data: Provider.of<FireStoreProvider>(context)
                                    .data["username"],
                                leadingIcon:
                                    "assets/images/Icon simple-email.png",
                                titleName: "Username",
                                trailingIcon:
                                    "assets/images/Icon material-edit.png",
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              UserListTile(
                                size: size,
                                data: Provider.of<FireStoreProvider>(context)
                                    .data['password'],
                                leadingIcon:
                                    "assets/images/Icon feather-lock.png",
                                titleName: "Password",
                                trailingIcon:
                                    "assets/images/Icon material-edit.png",
                              ),
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
                                  await Navigator.pushNamedAndRemoveUntil(
                                      context,
                                      SignInScreen.id,
                                      (route) => false);
                                  SharedPreferences prefs =
                                      await SharedPreferences.getInstance();
                                  prefs.remove("userLogin");
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
                          );
                        } else if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(child: CircularProgressIndicator());
                        }
                        return Text("No Data");
                      }))
            ]),
          ),
        ));
  }
}

AlertDialog alert(context) {
  TextEditingController _name = TextEditingController();
  return AlertDialog(
    title: Text("Edit Your Name"),
    backgroundColor: kDialogBoxColor,
    content: CustomFormField(
      controller: _name,
      hintText: Provider.of<FireStoreProvider>(context).data['name'],
    ),
    actions: [
      FlatButton(
          onPressed: () {
            Navigator.pop(context);
            Provider.of<FireStoreProvider>(context).setData(name: _name);
          },
          child: Text("Save")),
      FlatButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text("Cancel"))
    ],
  );
}
