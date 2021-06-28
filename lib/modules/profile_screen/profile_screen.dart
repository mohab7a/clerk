import 'package:clerk/models/user_model.dart';
import 'package:clerk/modules/auth_screens/login_screen/login_screen.dart';
import 'package:clerk/modules/profile_screen/saved_screen.dart';
import 'package:clerk/shared/components/defaults.dart';
import 'package:clerk/shared/cubit/cubit.dart';
import 'package:clerk/shared/cubit/states.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../shared/constants.dart';

class ProfileScreen extends StatelessWidget {
  static String id = "Profile Screen";
  final TextEditingController _name = TextEditingController();
  final TextEditingController _userName = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {
        if (state is UserSignOutSuccessState)
          navigateToAndFinish(context: context, page: LoginScreen.id);
      },
      builder: (context, state) {
        Size size = MediaQuery.of(context).size;
        UserModel model = AppCubit.get(context).userModel;
        AppCubit cubit = AppCubit.get(context);
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
              style:
                  TextStyle(color: kPrimaryColor, fontWeight: FontWeight.bold),
            ),
          ),
          body: Padding(
              padding: const EdgeInsets.all(20),
              child: ConditionalBuilder(
                condition: AppCubit.get(context).userModel != null,
                builder: (context) => SingleChildScrollView(
                  child: SizedBox(
                    width: double.infinity,
                    child: Column(
                      children: [
                        Stack(
                          children: [
                            CircleAvatar(
                                radius: 80,
                                backgroundColor: kPrimaryColor,
                                backgroundImage: cubit.image == null
                                    ? NetworkImage(model.userImage)
                                    : FileImage(cubit.image)),
                            Positioned(
                              right: 10,
                              bottom: 0,
                              child: GestureDetector(
                                onTap: () => cubit.getImage().then((value) {
                                  cubit.uploadProfileImage();
                                }),
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
                            userListTile(
                              size: size,
                              subtitle: model.name,
                              leadingIcon:
                                  "assets/images/Icon awesome-user-alt.png",
                              titleName: "Name",
                              trailingIcon:
                                  "assets/images/Icon material-edit.png",
                              onPressed: () {
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
                            userListTile(
                              size: size,
                              subtitle: model.email,
                              leadingIcon:
                                  "assets/images/Icon material-email.png",
                              titleName: "Email",
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            userListTile(
                              size: size,
                              subtitle: model.userName,
                              leadingIcon:
                                  "assets/images/Icon simple-email.png",
                              titleName: "Username",
                              trailingIcon:
                                  "assets/images/Icon material-edit.png",
                              onPressed: () {
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
                            userListTile(
                                size: size,
                                subtitle: model.password != null
                                    ? "********"
                                    : model.password,
                                leadingIcon:
                                    "assets/images/Icon feather-lock.png",
                                titleName: "Password",
                                trailingIcon:
                                    "assets/images/Icon material-edit.png",
                                onPressed: () {
                                  newPasswordDialog(context, model);
                                }),
                            SizedBox(
                              height: 10,
                            ),
                            GestureDetector(
                              onTap: () {
                                cubit.getSavedDocs();
                                navigateTo(
                                    context: context, page: SavedScreen.id);
                              },
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
                              onTap: () {
                                cubit.signOut();
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
                ),
                fallback: (context) => Center(child: kLoadingCircle),
              )),
        );
      },
    );
  }
}
