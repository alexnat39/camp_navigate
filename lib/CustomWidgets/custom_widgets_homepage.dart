import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

class CustomPhysicalButton extends StatefulWidget {
  final VoidCallback func;

  CustomPhysicalButton({required this.func});

  @override
  _CustomPhysicalButtonState createState() => _CustomPhysicalButtonState();
}

class _CustomPhysicalButtonState extends State<CustomPhysicalButton> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Container(
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
              onPressed: () {
                Navigator.pushNamed(context, '/physical');
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Text("Physical Activity", textAlign: TextAlign.center,),
          ),
        ],
      ),
    );
  }
}

class CustomNutritionButton extends StatefulWidget {
  final VoidCallback func;

  CustomNutritionButton({required this.func});

  @override
  _CustomNutritionButtonState createState() => _CustomNutritionButtonState();
}

class _CustomNutritionButtonState extends State<CustomNutritionButton> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Container(
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
              onPressed: () {
                widget.func();
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Text("Nutrition", textAlign: TextAlign.center,),
          ),
        ],
      ),
    );
  }
}

class CustomMentalHealthButton extends StatefulWidget {
  final VoidCallback func;

  CustomMentalHealthButton({required this.func});

  @override
  _CustomMentalHealthButtonState createState() =>
      _CustomMentalHealthButtonState();
}

class _CustomMentalHealthButtonState extends State<CustomMentalHealthButton> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Container(
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
              onPressed: () {
                widget.func();
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Text("Mental Health", textAlign: TextAlign.center,),
          ),
        ],
      ),
    );
  }
}
