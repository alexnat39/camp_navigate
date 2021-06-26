import 'package:camp_navigate/CustomWidgets/UniversalWidgets/AppBarWidgets/container_app_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget{
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          CustomContainerAppBar(title: "Camp Navigate", isInitialPage: true,),
          Center(child: Container(child: Text('Camp Navigate'),)),
        ],
      )
    );
  }
}