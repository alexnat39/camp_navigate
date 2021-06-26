import 'package:camp_navigate/Admin/FireStoreLV.dart';
import 'package:flutter/material.dart';

import 'Add/Add.dart';

class Nutrition extends StatefulWidget {


  @override
  _NutritionState createState() => _NutritionState();
}

class _NutritionState extends State<Nutrition> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text('Nutrition'),),body: FireStoreLV('Nutrition'),floatingActionButton: FloatingActionButton( child: Icon(Icons.add),
        backgroundColor: Colors.green,
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => Add('Nutrition')));
        }),);
  }
}
