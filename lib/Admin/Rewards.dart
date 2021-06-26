import 'package:flutter/material.dart';

import 'Add/AddReward.dart';

class Rewards extends StatefulWidget {

  @override
  _RewardsState createState() => _RewardsState();
}

class _RewardsState extends State<Rewards> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text('Rewards'),),floatingActionButton: FloatingActionButton( child: Icon(Icons.add),
        backgroundColor: Colors.green,
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => AddReward('Rewards')));
        }),);
  }
}
