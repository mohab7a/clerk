import 'package:clerk/shared/constants.dart';
import 'package:clerk/networks/local/cache_helper.dart';
import 'package:clerk/networks/remote/dio_helper.dart';
import 'package:clerk/shared/cubit/cubit.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'modules/auth_screens/login_screen/login_screen.dart';
import 'modules/auth_screens/register_screen/register_screen.dart';
import 'modules/home_screen/home_screen.dart';
import 'modules/profile_screen/profile_screen.dart';
import 'modules/profile_screen/saved_screen.dart';
import 'shared/bloc_observer.dart';
import 'layout/home_layout.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await CacheHelper.init();
  DioHelper.init();
  Bloc.observer = MyBlocObserver();
  userId = CacheHelper.getData("token");
  runApp(
    BlocProvider(
      create: (context) => AppCubit()
        ..getUserData()
        ..translateText(text: ""),
      child: MaterialApp(
        theme: ThemeData(),
        debugShowCheckedModeBanner: false,
        title: 'Clerk',
        initialRoute: userId == null ? LoginScreen.id : HomeScreen.id,
        routes: {
          LoginScreen.id: (context) => LoginScreen(),
          RegisterScreen.id: (context) => RegisterScreen(),
          HomeLayout.id: (context) => HomeLayout(),
          HomeScreen.id: (context) => HomeScreen(),
          ProfileScreen.id: (context) => ProfileScreen(),
          SavedScreen.id: (context) => SavedScreen(),
        },
      ),
    ),
  );
}
