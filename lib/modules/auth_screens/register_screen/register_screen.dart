import 'package:clerk/modules/auth_screens/login_screen/login_screen.dart';
import 'package:clerk/modules/auth_screens/register_screen/register_cubit/cubit.dart';
import 'package:clerk/modules/auth_screens/register_screen/register_cubit/states.dart';
import 'package:clerk/modules/home_screen/home_screen.dart';
import 'package:clerk/shared/components/defaults.dart';
import 'package:clerk/shared/constants.dart';
import 'package:clerk/networks/local/cache_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterScreen extends StatelessWidget {
  static String id = "Register Screen";
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _name = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _userName = TextEditingController();
  final TextEditingController _password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppRegisterCubit(),
      child: BlocConsumer<AppRegisterCubit, AppRegisterStates>(
        listener: (context, state) {
          if (state is RegisterErrorState) {
            customSnackBar(text: state.error.toString(), context: context);
          } else if (state is RegisterSuccessState) {
            CacheHelper.setData(key: "token", value: state.userId)
                .then((value) {
              navigateToAndFinish(context: context, page: HomeScreen.id);
            });
          }
        },
        builder: (context, state) {
          AppRegisterCubit cubit = AppRegisterCubit.get(context);
          return SafeArea(
            child: Scaffold(
              resizeToAvoidBottomInset: false,
              backgroundColor: kBackgroundColor,
              body: Form(
                key: _formKey,
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () => Navigator.pop(context),
                            child: Image.asset(
                              "assets/images/Arrow back.png",
                              width: MediaQuery.of(context).size.width * 0.07,
                            ),
                          ),
                          SizedBox(
                              width: MediaQuery.of(context).size.width * 0.15),
                          Text(
                            "Create account",
                            style: TextStyle(
                                color: kPrimaryColor,
                                fontSize: 24,
                                fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.04),
                      customFormField(
                        isPassword: false,
                        controller: _name,
                        hintText: "Name",
                        validator: (value) {
                          if (value.isEmpty) return "Please enter your name";
                        },
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.025),
                      customFormField(
                        isPassword: false,
                        hintText: "Email",
                        controller: _email,
                        validator: (value) {
                          if (value.isEmpty) return "Please enter valid email";
                        },
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.025),
                      customFormField(
                          isPassword: false,
                          hintText: "Username",
                          controller: _userName,
                          validator: (value) {
                            if (value.isEmpty)
                              return "Please enter a valid username";
                          }),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.025),
                      customFormField(
                          isPassword: cubit.isPassword,
                          hintText: "Password",
                          controller: _password,
                          validator: (String value) {
                            if (value.isEmpty || value.length < 8)
                              return "Please enter Strong password";
                          },
                          suffix: cubit.suffix,
                          suffixFunction: () {
                            cubit.changePasswordVisibility();
                          }),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.025),
                      customFormField(
                          isPassword: cubit.isPassword,
                          hintText: "Confirm password",
                          validator: (value) {
                            if (value.isEmpty || value != _password.text)
                              return "Password don't match";
                          },
                          suffix: cubit.suffix,
                          suffixFunction: () {
                            cubit.changePasswordVisibility();
                          }),
                      Padding(
                        padding: const EdgeInsets.only(top: 50),
                        child: defaultButton(
                            text: "sign up",
                            onPressed: () {
                              if (_formKey.currentState.validate()) {
                                cubit.createEmailAndPassword(
                                    userName: _userName.text,
                                    password: _password.text,
                                    email: _email.text,
                                    name: _name.text);
                              }
                            }),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: defaultSocialButton(
                            color: Colors.white,
                            text: "continue with google",
                            context: context),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 25),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Do you have an account? ",
                              style:
                                  TextStyle(color: kPrimaryColor, fontSize: 17),
                            ),
                            GestureDetector(
                              onTap: () {
                                navigateTo(
                                    context: context, page: LoginScreen.id);
                              },
                              child: Text(
                                "Sign In",
                                style: TextStyle(
                                    color: kSecondaryColor,
                                    decoration: TextDecoration.underline,
                                    fontSize: 17),
                              ),
                            )
                          ],
                        ),
                      ),
                      Spacer()
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
