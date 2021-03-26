import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:project_app/constants.dart';

class TestScreen extends StatefulWidget {
  static String routeName = '/test_screen';

  @override
  _TestScreenState createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  @override
  Widget build(BuildContext context) {
    Size sized = MediaQuery.of(context).size;
    return Scaffold(
      body: buildCenter(),
    );
  }

  Center buildCenter() {
    return Center(
      child: SpinKitWave(
        color: orangePrimaryColor,
        size: 30,
        duration: Duration(milliseconds: 1500),
      ),
    );
  }
}
