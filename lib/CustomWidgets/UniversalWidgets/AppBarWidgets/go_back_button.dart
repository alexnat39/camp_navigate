import 'package:camp_navigate/Helpers/custom_colors.dart';
import 'package:camp_navigate/Helpers/custom_sizes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomGoBackButton extends StatefulWidget {
  bool isOnNormalPages;

  CustomGoBackButton({this.isOnNormalPages: false});

  @override
  _CustomGoBackButtonState createState() => _CustomGoBackButtonState();
}

class _CustomGoBackButtonState extends State<CustomGoBackButton> {
  @override
  Widget build(BuildContext context) {
    double? height = CustomSizes(context).getHeight(context);
    return Container(
      height: height! * 0.051,
      width: height * 0.051,
      decoration: new BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        color: CustomColors.GREY,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            blurRadius: 10.0,
          ),
        ],
      ),
      child: ClipOval(
        child: Material(
          color: CustomColors.WHITE, // Button color
          child: InkWell(
            splashColor: CustomColors.GREY, // Splash color
            onTap: () {
              Navigator.pop(context);
            },
            child: SizedBox(height: height * 0.051,
                width: height * 0.051, child: Icon(Icons.chevron_left, color: CustomColors.BLACK,)),
          ),
        ),
      ),
    );
  }
}