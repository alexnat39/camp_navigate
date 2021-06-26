import 'package:flutter/material.dart';

import 'Add/Add.dart';
import 'FireStoreLV.dart';

class Exercise extends StatefulWidget {

  @override
  _ExerciseState createState() => _ExerciseState();
}

class _ExerciseState extends State<Exercise> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Exercise'),),
      body: FireStoreLV('Exercise'),
      floatingActionButton: FloatingActionButton(child: Icon(Icons.add),
          backgroundColor: Colors.green,
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => Add('Exercise')));
          }),);
  }
}
