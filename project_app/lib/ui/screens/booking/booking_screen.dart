import 'package:flutter/material.dart';
import 'package:project_app/constants.dart';
import 'package:project_app/ui/screens/booking/components/not_booking.dart';

import 'body.dart';

class BookingScreen extends StatelessWidget {
  static String routeName = '/booking';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: greyColor,
      appBar: AppBar(
        title: Text(
          'สนามที่จอง',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: navyPrimaryColor,
          ),
        ),
      ),
      // body: NotBooking(),
      body: Body(),
    );
  }
}
