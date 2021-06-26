import 'package:flutter/material.dart';


class CustomSizes {
  static BuildContext ?context;
  static double ?width;
  static double ?height;

  CustomSizes(BuildContext context) {
    CustomSizes.context = context;

    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
  }

  double? getHeight(BuildContext context) {
    return height;
  }

  double? getWidth(BuildContext context) {
    return width;
  }

}
