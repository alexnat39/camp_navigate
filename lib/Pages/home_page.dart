import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:camp_navigate/CustomWidgets/custom_widgets_homepage.dart';
import 'package:camp_navigate/Services/user_service.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  var _userService = UserService();


  List<String> pointTypes = [
    'Total Points: ',
    'Physical Activity Points: ',
    'Nutrition Points: ',
    'Mental Health Points: ',
  ];

  @override

  Widget build(BuildContext context) {

    return ListView(
      shrinkWrap: true,
      children: <Widget>[
        Container(
          height: 200,
          child: ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: 4,
            itemBuilder: (context, index) {
              return Container(
                height: 50,
                child: Card(
                  child: ListTile(
                    onTap: ()  {
                    },
                    title: Text(pointTypes[index]),
                    trailing: (pointTypes[index].compareTo('Total Points: ')==0) ?Text('600'):Text('200'),
                  ),
                ),
              );
            },
          ),
        ),

        SizedBox(height: 40),

        CustomPhysicalButton(
            func: () => Navigator.pushNamed(context, "/physical")),
        SizedBox(height: 50),
        CustomNutritionButton(
            func: () => Navigator.pushNamed(context, "/nutrition")),
        SizedBox(height: 50),
        CustomMentalHealthButton(
            func: () => Navigator.pushNamed(context, "/mental")),
      ],
    );
  }
}
