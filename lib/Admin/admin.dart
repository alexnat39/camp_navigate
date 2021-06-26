import 'package:camp_navigate/Admin/Exercise.dart';
import 'package:camp_navigate/Admin/Mental.dart';
import 'package:camp_navigate/Admin/Nutrition.dart';
import 'package:camp_navigate/Helpers/custom_colors.dart';
import 'package:camp_navigate/Helpers/custom_sizes.dart';
import 'package:flutter/material.dart';

import 'Rewards.dart';

class Admin extends StatefulWidget {


  @override
  _AdminState createState() => _AdminState();
}

class _AdminState extends State<Admin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text('Control Center'),), body: GridView.count(

        primary: false,
        padding: const EdgeInsets.all(20),
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        crossAxisCount: 2,
        children: <Widget>[
          InkWell(
            onTap: () {
               Navigator.push(
               context,
               MaterialPageRoute(
               builder: (context) => Nutrition()));
            },
            child:
            Card(
              clipBehavior: Clip.hardEdge,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Image.asset(
                    'assets/anna-pelzer-IGfIGP5ONV0-unsplash.jpg',
                    fit: BoxFit.fill,
                    //height: CustomSizes(context).getHeight(context)! * .28,
                    scale: 0.4,
                  ),
                  Padding(
                      padding: EdgeInsets.all(10),
                      child: Text('Nutrition',
                          style: TextStyle(color: CustomColors.GREY, fontSize: 15),
                          textAlign: TextAlign.center)),
                ],
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              elevation: 5,
              margin: EdgeInsets.all(10),
            ),),
          InkWell(
            onTap: () {
               Navigator.push(
               context,
               MaterialPageRoute(
               builder: (context) => Exercise()));
            },
            child:
            Card(
              clipBehavior: Clip.hardEdge,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Image.asset(
                    'assets/unsplash-c59hEeerAaI-unsplash.jpg',
                    fit: BoxFit.fill,
                    //height: CustomSizes(context).getHeight(context)! * .28,
                    scale: 0.4,
                  ),
                  Padding(padding: EdgeInsets.all(10),
                      child: Text(
                          'Exercise', style: TextStyle(color: CustomColors.GREY, fontSize: 15),
                          textAlign: TextAlign.center)),
                ],
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              elevation: 5,
              margin: EdgeInsets.all(10),
            ),), InkWell(
            onTap: () {
               Navigator.push(
               context,
               MaterialPageRoute(
               builder: (context) => Mental()));
            },
            child:
            Card(
              clipBehavior: Clip.hardEdge,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Image.asset(
                    'assets/total-shape-Ianw4RdVuoo-unsplash.jpg',
                    fit: BoxFit.fill,
                    //height: CustomSizes(context).getHeight(context)! * .28,
                    scale: 0.5,
                  ),
                  Padding(padding: EdgeInsets.all(10),
                      child: Text(
                          'Mental Health', style: TextStyle(color: CustomColors.GREY, fontSize: 15),
                          textAlign: TextAlign.center)),
                ],
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              elevation: 5,
              margin: EdgeInsets.all(10),
            ),),InkWell(
            onTap: () {
               Navigator.push(
               context,
               MaterialPageRoute(
               builder: (context) => Rewards()));
            },
            child:
            Card(
              clipBehavior: Clip.hardEdge,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Image.asset(
                    'assets/giorgio-trovato-_XTY6lD8jgM-unsplash.jpg',
                    fit: BoxFit.fill,
                    //height: CustomSizes(context).getHeight(context)! * .28,
                    scale: 0.4,
                  ),
                  Padding(padding: EdgeInsets.all(10),
                      child: Text(
                          'Rewards', style: TextStyle(color: CustomColors.GREY, fontSize: 15),
                          textAlign: TextAlign.center)),
                ],
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              elevation: 5,
              margin: EdgeInsets.all(10),
            ),)
        ]));
  }
}
