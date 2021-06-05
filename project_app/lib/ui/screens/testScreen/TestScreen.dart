import 'package:flutter/material.dart';
import 'package:project_app/ui/screens/testScreen/googleMap/google_map_screen.dart';
import 'body.dart';

class TestScreen extends StatelessWidget {
  static String routeName = '/test_screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // body: Body(),
      body: GoogleMapScreen(),
    );
  }
}
