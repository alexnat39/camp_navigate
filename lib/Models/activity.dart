import 'package:flutter/material.dart';

class Activity {
  String title;
  int points;


  Activity(this.title, this.points);

  Map<String, dynamic> toMap() {
  var data = Map<String, dynamic>();
  data['title'] = title;
  data['points'] =points;
  return data;
  }
}