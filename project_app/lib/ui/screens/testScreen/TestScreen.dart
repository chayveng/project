import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:project_app/constants.dart';
import 'package:project_app/ui/components/rounded_button.dart';

class TestScreen extends StatefulWidget {
  static String routeName = '/test_screen';

  @override
  _TestScreenState createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  bool status = false;


  @override
  Widget build(BuildContext context) {
    Size sized = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.red, // status bar color
          brightness: Brightness.dark // status bar brightness
          ),
      // body: buildCenter(),
      body: Column(
        children: [
          SizedBox(height: 30),
          RoundedButton(
            // text: 'null',
            // onTap: () {
            //   showDialog(context: context, builder: (context) => ());
            // },
          ),
          SizedBox(height: 30),
          // CustomCheckBox(),

        ],
      ),
    );
  }
}
