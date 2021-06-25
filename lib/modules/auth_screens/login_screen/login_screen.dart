import 'package:clerk/modules/auth_screens/register_screen/register_screen.dart';
import 'package:clerk/modules/home_screen/home_screen.dart';
import 'package:clerk/shared/components/defaults.dart';
import 'package:clerk/shared/constants.dart';
import 'package:clerk/networks/local/cache_helper.dart';

import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'login_cubit/cubit.dart';
import 'login_cubit/states.dart';

class LoginScreen extends StatelessWidget {
  static String id = "login Screen";
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => AppLoginCubit(),
        child: BlocConsumer<AppLoginCubit, AppLoginStates>(
          listener: (context, state) {
            if (state is LoginSuccessState) {
              CacheHelper.setData(key: "token", value: state.userId)
                  .then((value) {
                navigateToAndFinish(context: context, page: HomeScreen.id);
              });
            } else if (state is LoginErrorState) {
              customSnackBar(context: context, text: state.error);
            }
          },
          builder: (context, state) {
            AppLoginCubit cubit = AppLoginCubit.get(context);
            return SafeArea(
              child: Scaffold(
                  resizeToAvoidBottomInset: false,
                  backgroundColor: kBackgroundColor,
                  body: Padding(
                    padding: EdgeInsets.all(40),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          Spacer(),
                          Image.asset(
                            "assets/images/clerk logo.png",
                            width: MediaQuery.of(context).size.width * 0.6,
                          ),
                          Spacer(),
                          customFormField(
                            isPassword: false,
                            controller: _email,
                            hintText: "E-mail",
                            keyboardType: TextInputType.emailAddress,
                            validator: (String value) {
                              if (value.isEmpty) return "Invalid Email";
                            },
                          ),
                          SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 0.03),
                          customFormField(
                              isPassword: cubit.isPassword,
                              controller: _password,
                              hintText: "Password",
                              keyboardType: TextInputType.visiblePassword,
                              validator: (value) {
                                if (value.isEmpty) return "Invalid Password";
                              },
                              suffix: cubit.suffix,
                              suffixFunction: () {
                                cubit.changePasswordVisibility();
                              }),
                          SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 0.03),
                          ConditionalBuilder(
                            condition: state is! LoginLoadingState,
                            builder: (context) => defaultButton(
                              color: kPrimaryColor,
                              text: "SIGN IN",
                              onPressed: () {
                                if (_formKey.currentState.validate()) {
                                  cubit.signInWithEmailAndPassword(
                                      email: _email.text,
                                      password: _password.text);
                                }
                              },
                            ),
                            fallback: (context) =>
                                Center(child: kLoadingCircle),
                          ),
                          SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 0.03),
                          Text(
                            "Forget Password?",
                            style: TextStyle(
                                decoration: TextDecoration.underline,
                                color: kSecondaryColor,
                                fontSize: 15),
                          ),
                          SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 0.04),
                          defaultSocialButton(
                              color: Colors.white,
                              text: "continue with google",
                              context: context),
                          SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 0.04),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Don't have an account? ",
                                style: TextStyle(
                                    color: kPrimaryColor, fontSize: 17),
                              ),
                              GestureDetector(
                                onTap: () {
                                  navigateTo(
                                      context: context,
                                      page: RegisterScreen.id);
                                },
                                child: Text(
                                  "Sign Up",
                                  style: TextStyle(
                                      color: kSecondaryColor,
                                      decoration: TextDecoration.underline,
                                      fontSize: 17),
                                ),
                              )
                            ],
                          ),
                          Spacer(),
                        ],
                      ),
                    ),
                  )),
            );
          },
        ));
  }
}
