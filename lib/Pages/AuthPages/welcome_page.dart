import 'package:camp_navigate/CustomWidgets/UniversalWidgets/custom_universal_button.dart';
import 'package:camp_navigate/Helpers/custom_colors.dart';
import 'package:camp_navigate/Helpers/custom_sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class WelcomeScreenPage extends StatefulWidget {
  @override
  _WelcomeScreenPageState createState() => _WelcomeScreenPageState();
}

class _WelcomeScreenPageState extends State<WelcomeScreenPage> {
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
        body: Padding(
          padding: EdgeInsets.only(
              top: height! * 0.130,
              bottom: height * 0.043),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                  child: Padding(
                    padding: EdgeInsets.only(
                        bottom: height * 0.05),
                    child: Container(
                      width: height * 0.224,
                      child: Text(
                        "Camp Navigate",
                        style: TextStyle(fontSize: 24),
                        textAlign: TextAlign.center,
                      )
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      bottom: height * 0.015),
                  child: CustomUniversalButton(
                    text: "Log In",
                    mainColor: CustomColors.WHITE,
                    textColor: CustomColors.PURPLE,
                    borderColor: CustomColors.PURPLE,
                    onPressedFunction: () {
                      Navigator.pushNamed(context, '/login');
                    },
                  ),
                ),
                CustomUniversalButton(
                  text: "Sign Up",
                  mainColor: CustomColors.PURPLE,
                  textColor: CustomColors.WHITE,
                  borderColor: CustomColors.PURPLE,
                  onPressedFunction: () {
                    Navigator.pushNamed(context, '/signup');
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
