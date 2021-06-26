import 'package:camp_navigate/CustomWidgets/UniversalWidgets/AppBarWidgets/container_app_bar.dart';
import 'package:camp_navigate/CustomWidgets/custom_widgets_homepage.dart';
import 'package:camp_navigate/Helpers/custom_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

class NutritionTrackerPage extends StatefulWidget {
  // const NutritionTrackerPage({Key? key}) : super(key: key);

  @override
  _NutritionTrackerPageState createState() => _NutritionTrackerPageState();
}

class _NutritionTrackerPageState extends State<NutritionTrackerPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: CustomColors.WHITE,
        body: ListView(
          children: [
            CustomContainerAppBar(title: "Camp Navigate", isInitialPage: false,),
            Center(child: Container(child: Text('Camp Navigate'),)),
          ],
        )
    );
  }
}
