import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:camp_navigate/CustomWidgets/custom_widgets_homepage.dart';

class HomePage extends StatefulWidget{
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Health Tracker',
          style: TextStyle(
            fontSize: 18,
            color: Colors.grey[800],
          ),
        ),
        elevation: 0,
      ),

      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget> [
          CustomPhysicalButton(func: () => Navigator.pushNamed(context, "/physical")),

          SizedBox(height: 50),

          CustomNutritionButton(func: () => Navigator.pushNamed(context, "/nutrition")),

          SizedBox(height: 50),

          CustomMentalHealthButton(func: () => Navigator.pushNamed(context, "/mental")),
        ],
      ),
    );
  }
}