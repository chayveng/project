import 'package:flutter/material.dart';
import 'package:project_app/ui/screens/booking/booking_screen.dart';
import 'package:project_app/ui/screens/home/home_screen.dart';
import 'package:project_app/ui/screens/other/other_screen.dart';

import '../../../constants.dart';

class MainScreen extends StatefulWidget {
  static String routeName = '/main';

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;
  final tabs = [
    HomeScreen(),
    BookingScreen(),
    OtherScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: tabs[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        backgroundColor: orangePrimaryColor,
        selectedItemColor: greenPrimaryColor,
        unselectedItemColor: greenPrimaryColor,
        type: BottomNavigationBarType.fixed,
        // showUnselectedLabels: false,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: 'home',
            backgroundColor: Colors.white,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today_outlined),
            label: 'booking',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: 'other',
            backgroundColor: Colors.lightGreenAccent
          ),
        ],
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
