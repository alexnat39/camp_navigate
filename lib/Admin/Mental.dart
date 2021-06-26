import 'package:camp_navigate/Admin/FireStoreLV.dart';
import 'package:flutter/material.dart';

import 'Add/Add.dart';

class Mental extends StatefulWidget {


  @override
  _MentalState createState() => _MentalState();
}

class _MentalState extends State<Mental> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Mental'),),
      body: FireStoreLV('Mental'),
      floatingActionButton: FloatingActionButton(child: Icon(Icons.add),
          backgroundColor: Colors.green,
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => Add('Mental')));
          }),);
  }
}
