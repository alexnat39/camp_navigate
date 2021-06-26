import 'package:auto_size_text/auto_size_text.dart';
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
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignUpPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SignUpPageState();
  }
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _firstNameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _repeatedPasswordController = TextEditingController();
  TextEditingController _lastNameController = TextEditingController();

  final _emailFormKey = GlobalKey<FormState>();
  final _firstNameFormKey = GlobalKey<FormState>();
  final _passwordFormKey = GlobalKey<FormState>();
  final _repeatedPasswordFormKey = GlobalKey<FormState>();
  final _lastNameFormKey = GlobalKey<FormState>();

  bool _emailIsValid = false;
  bool _isPasswordValid = false;
  bool _isRepeatedPasswordValid = false;
  bool _isLastNameValid = false;
  bool _isFirstNameValid = false;
  
  //instance variable of user service
  UserService get userService => GetIt.instance<UserService>();

  AuthenticationService get authenticationService => GetIt.instance<AuthenticationService>();

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
            physics: ScrollPhysics(),
            children: [
              CustomContainerAppBar(title: "Sign Up", isInitialPage: false,),
              Padding(
                padding: EdgeInsets.only(
                    left: width! * 0.04,
                    right: width * 0.04),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 10.0, right: 10.0, top: height! * 0.01),
                          child: Form(
                            key: _firstNameFormKey,
                            child: TextFormField(
                              keyboardType: TextInputType.name,
                              controller: _firstNameController,
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
                                  borderSide: BorderSide(color: CustomColors.PURPLE),
                                ),
                                border: UnderlineInputBorder(
                                    borderSide: BorderSide(color: CustomColors.GREY)),
                                hintText: "First name",
                                labelText: "First name",
                                labelStyle: TextStyle(color: CustomColors.GREY),
                                hintStyle: TextStyle(
                                  color: CustomColors.GREY,
                                ),
                              ),
                              validator: (value) {
                                if (value!.trim().isEmpty) {
                                  _isFirstNameValid = false;
                                  return "Enter your first name";
                                } else {
                                  _isFirstNameValid = true;
                                  return null;
                                }
                              },
                            ),
                          ),
                        ), //TEXT FIELD FOR NAME
                        Padding(
                          padding:
                           EdgeInsets.only(left: 10.0, right: 10.0, top: height * 0.01),
                          child: Form(
                            key: _lastNameFormKey,
                            child: TextFormField(
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(11),
                              ],
                              keyboardType: TextInputType.name,
                              controller: _lastNameController,
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
                                  borderSide: BorderSide(color: CustomColors.PURPLE),
                                ),
                                border: UnderlineInputBorder(
                                    borderSide: BorderSide(color: CustomColors.GREY)),
                                hintText: "Last name",
                                labelText: "Last name",
                                labelStyle: TextStyle(color: CustomColors.GREY),
                                hintStyle: TextStyle(
                                  color: CustomColors.GREY,
                                ),
                              ),
                              validator: (value) {
                                if (value!.trim().isEmpty) {
                                  _isLastNameValid = false;
                                  return "Enter your last name";
                                } else {
                                  _isLastNameValid = true;
                                  return null;
                                }
                              },
                            ),
                          ),
                        ),
                        Padding(
                          padding:
                          EdgeInsets.only(left: 10.0, right: 10.0, top: height * 0.01),
                          child: Form(
                            key: _emailFormKey,
                            child: TextFormField(
                              keyboardType: TextInputType.emailAddress,
                              controller: _emailController,
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
                                  borderSide: BorderSide(color: CustomColors.PURPLE),
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
                              validator: (value) {
                                if (value!.trim().isEmpty) {
                                  _emailIsValid = false;
                                  return "Enter your email";
                                } else if (!RegExp(
                                    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                    .hasMatch(value)) {
                                  _emailIsValid = false;
                                  return "Email is badly formatted";
                                } else {
                                  _emailIsValid = true;
                                  return null;
                                }
                              },
                            ),
                          ),
                        ), //TEXT FIELD FOR EMAIL
                        Padding(
                          padding:
                          EdgeInsets.only(left: 10.0, right: 10.0, top: height * 0.01),
                          child: Form(
                            key: _passwordFormKey,
                            child: TextFormField(
                              obscureText: true,
                              keyboardType: TextInputType.visiblePassword,
                              controller: _passwordController,
                              maxLines: 1,
                              cursorColor: CustomColors.GREY,
                              decoration: InputDecoration(
                                errorStyle: TextStyle(color: Colors.red[300]),
                                errorBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.red[300]!)),
                                focusedErrorBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.red[300]!),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: CustomColors.PURPLE),
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
                              validator: (value) {
                                if (value!.trim().isEmpty) {
                                  _isPasswordValid = false;
                                  return "Enter a password";
                                } else {
                                  _isPasswordValid = true;
                                  return null;
                                }
                              },
                            ),
                          ),
                        ), //TEXT FIELD FOR PASSWORD
                        Padding(
                          padding:
                          EdgeInsets.only(left: 10.0, right: 10.0, top: height * 0.01),
                          child: Form(
                            key: _repeatedPasswordFormKey,
                            child: TextFormField(
                              obscureText: true,
                              keyboardType: TextInputType.visiblePassword,
                              controller: _repeatedPasswordController,
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
                                  borderSide: BorderSide(color: CustomColors.PURPLE),
                                ),
                                border: UnderlineInputBorder(
                                    borderSide: BorderSide(color: CustomColors.GREY)),
                                hintText: "Repeat password",
                                labelText: "Repeat password",
                                labelStyle: TextStyle(color: CustomColors.GREY),
                                hintStyle: TextStyle(
                                  color: CustomColors.GREY,
                                ),
                              ),
                              validator: (value) {
                                if (value!.trim().isEmpty) {
                                  _isRepeatedPasswordValid = false;
                                  return "Enter the password again";
                                } else if (value.trim() !=
                                    _passwordController.text) {
                                  _isRepeatedPasswordValid = false;
                                  return "Passwords don't match";
                                } else {
                                  _isRepeatedPasswordValid = true;
                                  return null;
                                }
                              },
                            ),
                          ),
                        ), //TEXT FIELD FOR REPEATED PASSWORD
                      ],
                    ),

                    Center(
                      child: Padding(
                        padding: EdgeInsets.only(
                          top: height * 0.02,
                        ),
                        child: CustomUniversalButton(
                          text: "Sign Up",
                          mainColor: CustomColors.WHITE,
                          textColor: CustomColors.PURPLE,
                          borderColor: CustomColors.PURPLE,
                          onPressedFunction: () async {
                            _emailFormKey.currentState!.validate();
                            _firstNameFormKey.currentState!.validate();
                            _lastNameFormKey.currentState!.validate();
                            _passwordFormKey.currentState!.validate();
                            _repeatedPasswordFormKey.currentState!.validate();

                            if (_emailIsValid &&
                                _isLastNameValid &&
                                _isFirstNameValid &&
                                _isPasswordValid &&
                                _isRepeatedPasswordValid) {
                              //showing loading dialog
                              showLoadingDialog(context);

                              //sending request to the server
                              int response = await authenticationService.signUpWithEmail(
                                  _emailController.text,
                                  _passwordController.text,
                              );
                              switch (response) {
                                case 0:
                                  {
                                    try {
                                      await userService.addUser(
                                          firstName: _firstNameController.text,
                                          lastName: _lastNameController.text,
                                          email: _emailController.text,
                                          id: FirebaseAuth.instance.currentUser!.uid);
                                      await userService.fetchUserData().then((data) {
                                        print(data);
                                        var _userVM = Provider.of<UserVM>(context,
                                            listen: false);
                                        _userVM.firstName = data['first_name'];
                                        _userVM.lastName = data['last_name'];
                                        _userVM.email = data['email'];
                                        _userVM.password = _passwordController.text;
                                        _userVM.id =
                                            FirebaseAuth.instance.currentUser!.uid;
                                      });
                                      SharedPreferences _prefs =
                                      await SharedPreferences.getInstance();
                                      _prefs.setString(
                                          "email", _emailController.text);
                                      _prefs.setString(
                                          "password", _passwordController.text);
                                      //hiding loading dialog
                                      Navigator.pop(context);
                                      Navigator.pushNamed(context, "/home");
                                    } catch (e) {
                                      //popping loading dialog
                                      Navigator.pop(context);
                                      showAlert(context, "An error occurred");
                                    }
                                    break;
                                  }
                                case 1:
                                  {
                                    //hiding loading dialog
                                    Navigator.pop(context);
                                    return showAlert(context,
                                        "The password provided is too weak.");
                                  }
                                case 2:
                                  {
                                    //hiding loading dialog
                                    Navigator.pop(context);
                                    return showAlert(
                                        context, "This E-mail is already in use.");
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
                    ),
                    Center(
                      child: Padding(
                        padding: EdgeInsets.only(
                          top: height * 0.02,
                          bottom:
                          height * 0.02,
                        ),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.popAndPushNamed(context, '/login');
                          },
                          child: Text("Log In",
                              style: TextStyle(
                                  color: CustomColors.GREY,
                                  fontFamily: 'GothamProNormal')),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
