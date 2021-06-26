import 'package:camp_navigate/Helpers/custom_colors.dart';
import 'package:camp_navigate/Helpers/custom_sizes.dart';
import 'package:camp_navigate/Services/authentication_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'go_back_button.dart';

class CustomContainerAppBar extends StatefulWidget {
  String title;
  bool isInitialPage;
  bool isLogOutButtonNeeded;

  CustomContainerAppBar({
    required this.title,
    required this.isInitialPage,
    this.isLogOutButtonNeeded: false,
  });

  @override
  _CustomContainerAppBarState createState() => _CustomContainerAppBarState();
}

class _CustomContainerAppBarState extends State<CustomContainerAppBar> {
  AuthenticationService get authenticationService =>
      GetIt.instance<AuthenticationService>();

  @override
  Widget build(BuildContext context) {
    double? width = CustomSizes(context).getWidth(context);
    double? height = CustomSizes(context).getHeight(context);

    return Container(
        color: CustomColors.WHITE,
        height: height! * 0.076,
        child: IntrinsicHeight(
          child: Padding(
            padding: EdgeInsets.only(
              left: width! * 0.025,
              right: width * 0.025,
            ),
            child: Stack(
              children: [
                Positioned(
                  child: (widget.isInitialPage)
                      ? Container()
                      : Align(
                          alignment: Alignment.centerLeft,
                          child: CustomGoBackButton()),
                ),
                Align(
                  child: Container(
                    width: width * 0.7,
                    child: Center(
                      child: Text(
                        this.widget.title,
                        style: TextStyle(fontSize: 24),
                      ),
                    ),
                  ),
                ),
                Positioned(
                    child: Align(
                  alignment: Alignment.centerRight,
                  child: (widget.isLogOutButtonNeeded)
                      ? GestureDetector(
                          onTap: () {
                            Navigator.popAndPushNamed(context, "/welcome");
                            authenticationService.signOut();
                          },
                          child: Icon(
                            Icons.logout,
                            color: CustomColors.BLUE,
                          ))
                      : SizedBox(
                          height: 0,
                          width: width * 0.05,
                        ),
                )),
              ],
            ),
          ),
        ));
  }
}
