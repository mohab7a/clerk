import 'package:clerk/view/home_screen/home_screen.dart';
import 'package:clerk/view/profile_screen/profile_screen.dart';
import 'package:clerk/view/signin_screens/signin_screen.dart';
import 'package:clerk/view/signup_screen/signup_screen.dart';
import 'package:clerk/view/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var loggedIn = prefs.getBool("userLogin") ?? false;

  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Clerk',
    initialRoute: loggedIn == true ? HomeScreen.id : SignInScreen.id,
    routes: {
      SplashScreen.id: (context) => SplashScreen(),
      SignInScreen.id: (context) => SignInScreen(),
      SignUpScreen.id: (context) => SignUpScreen(),
      HomeScreen.id: (context) => HomeScreen(),
      ProfileScreen.id: (context) => ProfileScreen()
    },
  ));
}
