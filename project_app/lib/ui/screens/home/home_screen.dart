import 'package:flutter/material.dart';

import '../../../constants.dart';
import 'body.dart';

class HomeScreen extends StatefulWidget {
  static String routeName = '/home';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final double iconSize = 40;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: greyPrimaryColor,
      backgroundColor: greyColor,
      // appBar: AppBar(
      //   title: Text('Home'),
      // ),
      body: Body(),
    );
  }
}
