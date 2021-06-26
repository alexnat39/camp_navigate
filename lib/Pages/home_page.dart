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

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[

        Container(
          width: MediaQuery.of(context).size.width,
          height: 200,
          child: ListView.builder(
            itemCount: 4,
            itemBuilder: (context, index) {
              return Container(
                height: 50,
                child: Card(
                  child: ListTile(
                    onTap: ()  {
                    },
                    title: Text(pointTypes[index]),
                    trailing: Text('5'),
                  ),
                ),
              );
            },
          ),
        ),

        SizedBox(height: 30),

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
