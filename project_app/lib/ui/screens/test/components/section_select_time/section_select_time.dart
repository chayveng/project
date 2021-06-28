import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_app/constants.dart';
import 'package:project_app/ui/screens/test/components/section_select_time/time_spinner.dart';

class SectionSelectTime extends StatefulWidget {
  final TimeOfDay? timeOfDay;

  const SectionSelectTime({Key? key, this.timeOfDay}) : super(key: key);

  @override
  _SectionSelectTimeState createState() => _SectionSelectTimeState();
}

class _SectionSelectTimeState extends State<SectionSelectTime> {
  var hour = List.generate(24, (index) => index);
  var min = List.generate(6, (index) => index * 10);
  int isHour = 0;
  int isMin = 0;

  Container selectTimeSpinner() {
    return Container(
      width: sized(context).width,
      height: 200,
      color: Colors.blue,
      child: Stack(
        children: [
          Center(
            child: Container(
              width: 350,
              height: 200 / 4,
              decoration: BoxDecoration(
                color: orangePrimaryColor,
                borderRadius: BorderRadius.circular(14),
              ),
            ),
          ),
          Center(
            child: Container(
              width: 230,
              // color: Colors.yellow,
              child: Row(
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        Expanded(child: TimeSpinner(lst: hour)),
                        Expanded(
                          child: Text(
                            'Hour',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                      child: Row(
                    children: [
                      Expanded(child: TimeSpinner(lst: min)),
                      Expanded(
                        child: Text(
                          'Min',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                      ),
                    ],
                  )),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        selectTimeSpinner(),
      ],
    );
  }
}
