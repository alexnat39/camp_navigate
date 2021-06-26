import 'package:auto_size_text/auto_size_text.dart';
import 'package:camp_navigate/CustomWidgets/UniversalWidgets/AppBarWidgets/container_app_bar.dart';
import 'package:camp_navigate/CustomWidgets/UniversalWidgets/custom_universal_button.dart';
import 'package:camp_navigate/CustomWidgets/UniversalWidgets/show_alert.dart';
import 'package:camp_navigate/CustomWidgets/UniversalWidgets/show_loading_dialog.dart';
import 'package:camp_navigate/Helpers/custom_colors.dart';
import 'package:camp_navigate/Helpers/custom_sizes.dart';
import 'package:camp_navigate/Services/authentication_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get_it/get_it.dart';

class ResetPasswordPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ResetPasswordPageState();
  }
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  String userEmail = "";

  TextEditingController _emailController = TextEditingController();
  final _emailFormKey = GlobalKey<FormState>();
  bool _emailIsValid = false;

  AuthenticationService get authenticationService =>
      GetIt.instance<AuthenticationService>();

  @override
  Widget build(BuildContext context) {
    double? width = CustomSizes(context).getWidth(context);
    double? height = CustomSizes(context).getHeight(context);
    //_widgetsToDisplay = _buildResetPasswordWidgets(context);
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
              CustomContainerAppBar(title: "Reset Password", isInitialPage: false,),
              Padding(
                padding: EdgeInsets.only(
                    top: height! * 0.02,
                    left: width! * 0.04,
                    right: width * 0.04),
                child: Column(
                  children: [
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Flexible(
                            child: AutoSizeText(
                                "To reset the password, enter your E-mail",
                                style:
                                    TextStyle(fontFamily: "GothamProNormal")),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                      child: Form(
                        key: _emailFormKey,
                        child: TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          onChanged: (value) {
                            setState(() {
                              userEmail = value;
                            });
                          },
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
                            } else {
                              _emailIsValid = true;
                              return null;
                            }
                          },
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        top: height * 0.02,
                      ),
                      child: CustomUniversalButton(
                        text: "Reset",
                        mainColor: CustomColors.WHITE,
                        textColor: CustomColors.PURPLE,
                        borderColor: CustomColors.PURPLE,
                        onPressedFunction: () async {
                          _emailFormKey.currentState!.validate();
                          if (_emailIsValid) {
                            FocusScope.of(context).unfocus();
                            //showing loading dialog
                            showLoadingDialog(context);
                            int result = await authenticationService
                                .resetPassword(_emailController.text);
                            //hiding loading dialog
                            Navigator.pop(context);
                            switch (result) {
                              case 0:
                                {
                                  showAlert(context,
                                      "An email has been sent to ${_emailController.text}.",
                                      title: "Note");
                                  setState(() {
                                    _emailController.text = "";
                                  });
                                  break;
                                }
                              case 1:
                                {
                                  return showAlert(
                                      context, 'E-mail not found.');
                                }
                              case 2:
                                {
                                  return showAlert(
                                      context, "An error occurred");
                                }
                            }
                          }
                        },
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
