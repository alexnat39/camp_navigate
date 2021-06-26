import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

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
          Center(
            child: Container(
              width: 90,
              height: 90,
              child: RawMaterialButton(
                fillColor: Colors.red[300],
                shape: CircleBorder(),
                elevation: 0,
                child: Icon(
                  Icons.fitness_center,
                  size: 45.0,
                  color: Colors.white,
                ),
                onPressed: () {},
              ),
            ),
          ),

          SizedBox(height: 50),

          Center(
            child: Container(
              width: 90,
              height: 90,
              child: RawMaterialButton(
                fillColor: Colors.yellow[300],
                shape: CircleBorder(),
                elevation: 0,
                child: Icon(
                  LineIcons.carrot,
                  size: 45.0,
                  color: Colors.white,
                ),
                onPressed: () {},
              ),
            ),
          ),

          SizedBox(height: 50),

          Center(
            child: Container(
              width: 90,
              height: 90,
              child: RawMaterialButton(
                fillColor: Colors.green[300],
                shape: CircleBorder(),
                elevation: 0,
                child: Icon(
                  LineIcons.brain,
                  size: 45.0,
                  color: Colors.white,
                ),
                onPressed: () {},
              ),
            ),
          ),
        ],
      ),
    );
  }
}