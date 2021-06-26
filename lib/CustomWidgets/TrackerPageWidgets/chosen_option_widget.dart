import 'package:camp_navigate/Helpers/custom_colors.dart';
import 'package:camp_navigate/Helpers/custom_sizes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomChosenTrackerOptionWidget extends StatefulWidget {
  String optionName;

  CustomChosenTrackerOptionWidget({required this.optionName});

  @override
  _CustomChosenTrackerOptionWidgetState createState() => _CustomChosenTrackerOptionWidgetState();
}

class _CustomChosenTrackerOptionWidgetState extends State<CustomChosenTrackerOptionWidget> {
  @override
  Widget build(BuildContext context) {
    double? height = CustomSizes(context).getHeight(context);
    return Padding(
      padding: EdgeInsets.only(bottom: height! * 0.01),
      child: Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(12),
        ),
        height: height * 0.07,
        child: Card(
          elevation: 5,
          child: Padding(
             padding: EdgeInsets.only(left: 10, right: 10),
            child: Align(
              alignment: Alignment.centerLeft,
                child: Text(widget.optionName, style: TextStyle(fontSize: 18),)),
          ),
        ),
      ),
    );
  }
}