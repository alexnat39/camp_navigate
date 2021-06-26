import 'package:auto_size_text/auto_size_text.dart';
import 'package:camp_navigate/Helpers/custom_colors.dart';
import 'package:camp_navigate/Helpers/custom_sizes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'go_back_button.dart';

class CustomContainerAppBar extends StatefulWidget {
  String title;
  bool isInitialPage;

  CustomContainerAppBar({
    required this.title,
    required this.isInitialPage,
  });

  @override
  _CustomContainerAppBarState createState() => _CustomContainerAppBarState();
}

class _CustomContainerAppBarState extends State<CustomContainerAppBar> {
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
                      child: Text(this.widget.title, style: TextStyle(fontSize: 24),),
                    ),
                  ),
                ),
                Positioned(
                    child: Align(
                  alignment: Alignment.centerRight,
                  child: SizedBox(
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
