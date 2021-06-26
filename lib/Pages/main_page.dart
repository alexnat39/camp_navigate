import 'package:camp_navigate/CustomWidgets/UniversalWidgets/AppBarWidgets/container_app_bar.dart';
import 'package:camp_navigate/Helpers/custom_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'RewardsPage/rewards_page.dart';
import 'home_page.dart';

class MainPage extends StatefulWidget {


  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  static List<Widget> _widgetOptions = <Widget>[
    HomePage(),
    RewardsPage(),
    Text(
      'Index 2: School',
    ),
  ];
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.WHITE,
      body: ListView(
        padding: EdgeInsets.zero,
        physics: NeverScrollableScrollPhysics(),
        children: [
          CustomContainerAppBar(
            title: "Camp Navigate",
            isInitialPage: true,
          ),
          _widgetOptions.elementAt(_selectedIndex),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
            backgroundColor: Colors.red,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.monetization_on),
            label: 'Rewards',
            backgroundColor: Colors.green,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'More',
            backgroundColor: Colors.pink,
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}