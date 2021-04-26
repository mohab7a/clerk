import 'package:clerk/view/home_screen/home_screen.dart';
import 'package:clerk/view/profile_screen/profile_screen.dart';
import 'package:clerk/view/auth_screens/signin_screens/signin_screen.dart';
import 'package:clerk/view/auth_screens/signup_screen/signup_screen.dart';
import 'package:clerk/view_model/Provider/FirebaseProvider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'view/features_screens/nav_bar.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  //SharedPreferences prefs = await SharedPreferences.getInstance();
  //var loggedIn = prefs.getBool("userLogin") ?? false;
  FirebaseAuth _auth = FirebaseAuth.instance;

  runApp(ChangeNotifierProvider(
    create: (context) => FireStoreProvider(),
    builder: (context, child) => WillPopScope(
      onWillPop: () async => false,
      child: MaterialApp(
        theme: ThemeData(),
        debugShowCheckedModeBanner: false,
        title: 'Clerk',
        initialRoute:
            _auth.currentUser == null ? SignInScreen.id : HomeScreen.id,
        routes: {
          SignInScreen.id: (context) => SignInScreen(),
          SignUpScreen.id: (context) => SignUpScreen(),
          NavigationBar.id: (context) => NavigationBar(),
          HomeScreen.id: (context) => HomeScreen(),
          ProfileScreen.id: (context) => ProfileScreen()
        },
      ),
    ),
  ));
}
