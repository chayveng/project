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
        elevation: 0,
        currentIndex: _currentIndex!,
        backgroundColor: Colors.white,
        selectedItemColor: orangeColor,
        unselectedItemColor: Colors.black.withOpacity(0.3),
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: true,
        showUnselectedLabels: false,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home, size: 30),
            label: 'หน้าหลัก',
            backgroundColor: Colors.white,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bookmark),
            label: 'สนามที่จอง',
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.person, size: 30),
              label: 'อื่น ๆ',
              backgroundColor: Colors.lightGreenAccent),
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
