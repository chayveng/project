import 'package:flutter/material.dart';
import 'package:project_app/ui/screens/booking/booking_screen.dart';
import 'package:project_app/ui/screens/home/home_screen.dart';
import 'package:project_app/ui/screens/other/other_screen.dart';

import '../../../constants.dart';

class MainScreen extends StatefulWidget {
  static String routeName = '/main';
  final int? currentIndex;

  const MainScreen({Key? key, this.currentIndex}) : super(key: key);
  @override
  _MainScreenState createState() => _MainScreenState(currentIndex);
}

class _MainScreenState extends State<MainScreen> {
  int? currentIndex;
  int? _currentIndex = 0;
  final tabs = [
    HomeScreen(),
    BookingScreen(),
    OtherScreen(),
  ];

  _MainScreenState(this.currentIndex);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: tabs[currentIndex != null ? currentIndex! : _currentIndex!],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex!,
        backgroundColor: orangePrimaryColor,
        selectedItemColor: navyPrimaryColor,
        unselectedItemColor: navyPrimaryColor,
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
            currentIndex = null;
            // _currentIndex = currentIndex == null ? index : currentIndex;
          });
        },
      ),
    );
  }
}