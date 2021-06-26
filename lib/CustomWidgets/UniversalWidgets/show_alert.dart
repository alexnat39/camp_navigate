import 'package:camp_navigate/Helpers/custom_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void showAlert(BuildContext context, String errorMessage, {String title : 'An error occurred'}) {
  showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(8.0))),
        title: Text(
          title,
          style: TextStyle(color: CustomColors.PURPLE),
        ),
        content: Text(
          '$errorMessage',
          style: TextStyle(),
        ),
      ));
}