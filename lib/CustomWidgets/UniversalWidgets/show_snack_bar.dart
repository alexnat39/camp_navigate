import 'package:camp_navigate/Helpers/custom_colors.dart';
import 'package:flutter/material.dart';

showCustomSnackBar(context, text) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(
      text,
      textAlign: TextAlign.center,
      style: TextStyle(color: Colors.green, fontSize: 16),
    ),
    backgroundColor: CustomColors.WHITE,
    elevation: 5,
    duration: Duration(seconds: 1),
  ));
}