import 'package:flutter/material.dart';
import 'package:project_app/constants.dart';

import '../../../constants.dart';
import '../../../constants.dart';
import '../../../constants.dart';
import 'components/body.dart';

class BookingScreen extends StatelessWidget {
  static String routeName = '/booking';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: grayPrimaryColor,
      appBar: AppBar(
        title: Text(
          'Booking',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: greenPrimaryColor,
          ),
        ),
        backgroundColor: creamPrimaryColor,
      ),
      body: Body(),
    );
  }
}
