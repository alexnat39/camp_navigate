import 'package:camp_navigate/CustomWidgets/UniversalWidgets/AppBarWidgets/container_app_bar.dart';
import 'package:camp_navigate/Helpers/custom_colors.dart';
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
        backgroundColor: CustomColors.WHITE,
        body: ListView(
        children: [
          CustomContainerAppBar(title: "Camp Navigate", isInitialPage: true,),
          Column(
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
        ],
      )
    );
  }
}