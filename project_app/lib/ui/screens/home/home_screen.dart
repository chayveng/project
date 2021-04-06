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
      backgroundColor: grayPrimaryColor,
      body: Body(),
    );
  }
}