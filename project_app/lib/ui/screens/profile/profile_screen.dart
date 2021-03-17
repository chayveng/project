import 'package:flutter/material.dart';
import 'package:project_app/constants.dart';

import 'components/body.dart';

class ProfileScreen extends StatefulWidget {
  static String routeName = '/profile';

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  int _selectedIndex = 3;
  final Color colorBackground = whiteBackgroundColor;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(),
      // bottomNavigationBar: BottomBar(),
    );
  }
}
