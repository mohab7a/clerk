import 'package:clerk/view/home_screen/home_screen.dart';
import 'package:clerk/view/profile_screen/profile_screen.dart';
import 'package:clerk/view/signin_screens/signin_screen.dart';
import 'package:clerk/view/signup_screen/signup_screen.dart';
import 'package:clerk/view_model/Provider/FirebaseProvider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'view/nav_bar.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var loggedIn = prefs.getBool("userLogin") ?? false;

  runApp(ChangeNotifierProvider(
    create: (context) => FireStoreProvider(),
    builder: (context, child) => MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Clerk',
      initialRoute: loggedIn == true ? HomeScreen.id : SignInScreen.id,
      routes: {
        SignInScreen.id: (context) => SignInScreen(),
        SignUpScreen.id: (context) => SignUpScreen(),
        NavigationBar.id: (context) => NavigationBar(),
        HomeScreen.id: (context) => HomeScreen(),
        HomeScreen.id: (context) => HomeScreen(),
        ProfileScreen.id: (context) => ProfileScreen()
      },
    ),
  ));
}
