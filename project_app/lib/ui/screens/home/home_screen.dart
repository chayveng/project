import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:project_app/constants.dart';

import 'components/body.dart';

class HomeScreen extends StatelessWidget {
  static String routeName = '/home';
  final double iconSize = 40;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Colors.red, // status bar color
      //   brightness: Brightness.light,
      // ),
      // appBar: AppBar(
      //   leading: Icon(Icons.search),
      //   iconTheme: IconThemeData(color: navyPrimaryColor),
      //   backgroundColor: creamPrimaryColor,
      //   title: Text(
      //     'Home',
      //     style: TextStyle(
      //       color: navyPrimaryColor,
      //       fontWeight: FontWeight.bold,
      //     ),
      //   ),
      // ),
      backgroundColor: grayPrimaryColor,
      body: Body(),
    );
  }
}