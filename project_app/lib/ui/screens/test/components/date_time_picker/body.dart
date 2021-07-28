import 'package:flutter/material.dart';
import 'package:project_app/constants.dart';
import 'package:project_app/core/models/Time.dart';
import 'package:project_app/ui/screens/test/components/dialog_date_time_picker/dialog_date_time_picker.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  List<Time> times = [];
  DateTime currentDateTime = DateTime.now();
  DateTime newDateTime = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Column(
          children: [
            testButton(
              text: 'DateTimePicker',
              onPressed: () async {
               await showDialog(
                  context: context,
                  builder: (context) => DialogDateTimePicker(),
                ).then((value) {
                  print(value);
               });
                print('DateTimePicker');
              },
            ),
            testButton(
              onPressed: () {
                print(currentDateTime.toString());
              },
            ),
          ],
        ),
      ),
    );
  }
}
