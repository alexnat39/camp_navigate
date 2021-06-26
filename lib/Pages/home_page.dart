import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:camp_navigate/CustomWidgets/custom_widgets_homepage.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        SizedBox(height: 100),
        CustomPhysicalButton(
            func: () => Navigator.pushNamed(context, "/physical")),
        SizedBox(height: 50),
        CustomNutritionButton(
            func: () => Navigator.pushNamed(context, "/nutrition")),
        SizedBox(height: 50),
        CustomMentalHealthButton(
            func: () => Navigator.pushNamed(context, "/mental")),
      ],
    );
  }
}
