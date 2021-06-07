import 'package:flutter/material.dart';
import 'package:project_app/ui/screens/testScreen/date_time/date_time.dart';
import 'package:project_app/ui/screens/testScreen/googleMap/google_map_screen.dart';
import 'package:project_app/ui/screens/testScreen/test_font.dart';
import 'body.dart';

class TestScreen extends StatelessWidget {
  static String routeName = '/test_screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // body: Body(),
      // body: GoogleMapScreen(),
      // body: TestFont(),
      body: DateTimePicker(),
    );
  }
}
