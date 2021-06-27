import 'package:camp_navigate/CustomWidgets/UniversalWidgets/AppBarWidgets/container_app_bar.dart';
import 'package:camp_navigate/CustomWidgets/UniversalWidgets/custom_universal_button.dart';
import 'package:camp_navigate/CustomWidgets/UniversalWidgets/show_alert.dart';
import 'package:camp_navigate/CustomWidgets/UniversalWidgets/show_loading_dialog.dart';
import 'package:camp_navigate/Helpers/custom_colors.dart';
import 'package:camp_navigate/Helpers/custom_sizes.dart';
import 'package:camp_navigate/Models/UserVM.dart';
import 'package:camp_navigate/Services/authentication_service.dart';
import 'package:camp_navigate/Services/user_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  //instance variable of user service
  UserService get userService => GetIt.instance<UserService>();

  AuthenticationService get authenticationService =>
      GetIt.instance<AuthenticationService>();

  @override
  Widget build(BuildContext context) {
    double? width = CustomSizes(context).getWidth(context);
    double? height = CustomSizes(context).getHeight(context);
    return WillPopScope(
      onWillPop: () async {
        if (Navigator.of(context).userGestureInProgress)
          return false;
        else
          return true;
      },
      child: Scaffold(
        backgroundColor: CustomColors.WHITE,
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: ListView(
            physics: NeverScrollableScrollPhysics(),
            children: [
              CustomContainerAppBar(title: "Login", isInitialPage: false,),
              Padding(
                padding: EdgeInsets.only(
                    top: height! * 0.02,
                    left: width! * 0.04,
                    right: width * 0.04),
                child: Column(
                  children: [
                    Padding(
                      padding:  EdgeInsets.only(left: 10.0, right: 10.0),
                      child: TextField(
                        controller: _emailController,
                        maxLines: 1,
                        cursorColor: CustomColors.GREY,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          errorStyle: TextStyle(color: Colors.red[300]),
                          errorBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.red[300]!)),
                          focusedErrorBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.red[300]!),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: CustomColors.BLUE),
                          ),
                          border: UnderlineInputBorder(
                              borderSide: BorderSide(color: CustomColors.GREY)),
                          hintText: "E-mail",
                          labelText: "E-mail",
                          labelStyle: TextStyle(color: CustomColors.GREY),
                          hintStyle: TextStyle(
                            color: CustomColors.GREY,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding:  EdgeInsets.only(left: 10.0, right: 10.0, top: height * 0.01),
                      child: TextField(
                        obscureText: true,
                        controller: _passwordController,
                        maxLines: 1,
                        cursorColor: CustomColors.GREY,
                        //keyboardType: inputType,
                        decoration: InputDecoration(
                          errorStyle: TextStyle(color: Colors.red[300]),
                          errorBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.red[300]!)),
                          focusedErrorBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.red[300]!),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: CustomColors.BLUE),
                          ),
                          border: UnderlineInputBorder(
                              borderSide: BorderSide(color: CustomColors.GREY)),
                          hintText: "Password",
                          labelText: "Password",
                          labelStyle: TextStyle(color: CustomColors.GREY),
                          hintStyle: TextStyle(
                            color: CustomColors.GREY,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        top: height * 0.02,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.popAndPushNamed(context, '/reset_password');
                            },
                            child: Text("Forgot password?",
                                style: TextStyle(
                                    color: CustomColors.GREY,
                                    fontFamily: 'GothamProNormal')),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        top: height * 0.02,
                      ),
                      child: CustomUniversalButton(
                        text: "Log In",
                        mainColor: CustomColors.WHITE,
                        textColor: CustomColors.BLUE,
                        borderColor: CustomColors.BLUE,
                        onPressedFunction: () async {
                          if (_emailController.text != null &&
                              _passwordController.text != null) {
                            //showing loading dialog
                            showLoadingDialog(context);

                            //sending request to the server
                            int response = await authenticationService.signInWithEmail(
                              _emailController.text,
                              _passwordController.text,
                            );
                            switch (response) {
                              case 0:
                                {
                                  await userService
                                      .fetchUserData()
                                      .then((data) async {
                                    print(data);
                                    try {
                                      var _userVM = Provider.of<UserVM>(context,
                                          listen: false);
                                      _userVM.firstName = data['first_name'];
                                      _userVM.lastName = data['last_name'];
                                      _userVM.email = data['email'];
                                      _userVM.totalPoints = data['totalPoints'];
                                      _userVM.password = _passwordController.text;
                                      _userVM.id =
                                          FirebaseAuth.instance.currentUser!.uid;
                                      SharedPreferences _prefs =
                                      await SharedPreferences.getInstance();
                                      _prefs.setString(
                                          "email", _emailController.text);
                                      _prefs.setString(
                                          "password", _passwordController.text);
                                      _prefs.setString(
                                          "first_name", data['first_name']);
                                      _prefs.setString(
                                          "last_name", data['last_name']);
                                      _prefs.setInt(
                                          "total_points", data['totalPoints']);
                                      _prefs.setString(
                                          "id", data['id']);
                                      //hiding loading dialog
                                      Navigator.pop(context);
                                      Navigator.pushNamed(context, "/home");

                                    } catch (e) {
                                      //hiding loading dialog
                                      Navigator.pop(context);
                                      return showAlert(
                                          context, "An error occurred");
                                    }
                                  });
                                  break;
                                }
                              case 1:
                                {
                                  //hiding loading dialog
                                  Navigator.pop(context);
                                  return showAlert(
                                      context, "No user found for this email");
                                }
                              case 2:
                                {
                                  //hiding loading dialog
                                  Navigator.pop(context);
                                  return showAlert(
                                      context, "Password is incorrect");
                                }
                              case 3:
                                {
                                  //hiding loading dialog
                                  Navigator.pop(context);
                                  return showAlert(context, "An error occurred");
                                }
                            }
                          }
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        top: height * 0.02,
                      ),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.popAndPushNamed(context, '/signup');
                        },
                        child: Text("New user? Sign Up",
                            style: TextStyle(
                                color: CustomColors.GREY,
                                fontFamily: 'GothamProNormal')),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
