import 'package:camp_navigate/CustomWidgets/TrackerPageWidgets/chosen_option_widget.dart';
import 'package:camp_navigate/CustomWidgets/UniversalWidgets/AppBarWidgets/container_app_bar.dart';
import 'package:camp_navigate/CustomWidgets/UniversalWidgets/custom_universal_button.dart';
import 'package:camp_navigate/CustomWidgets/UniversalWidgets/show_alert.dart';
import 'package:camp_navigate/CustomWidgets/UniversalWidgets/show_loading_dialog.dart';
import 'package:camp_navigate/CustomWidgets/UniversalWidgets/show_snack_bar.dart';
import 'package:camp_navigate/Helpers/custom_colors.dart';
import 'package:camp_navigate/Services/physical_activity_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class MentalHealthTrackerPage extends StatefulWidget {

  @override
  _MentalHealthTrackerPageState createState() => _MentalHealthTrackerPageState();
}

class _MentalHealthTrackerPageState extends State<MentalHealthTrackerPage> {

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
