import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:project_app/constants.dart';
import 'package:project_app/core/models/Time.dart';
import 'package:project_app/ui/components/custom_alert_dialog.dart';
import 'package:project_app/ui/components/rounded_button.dart';

import 'custom_dialog_datetime_picker.dart';

class SectionTimes extends StatefulWidget {
  final List<Time>? times;

  const SectionTimes({Key? key, this.times}) : super(key: key);

  @override
  _SectionTimesState createState() => _SectionTimesState();
}

class _SectionTimesState extends State<SectionTimes> {
  DateTime? startTime;
  DateTime? endTime;
  Time _time = Time();
  List<Time> times = [];
  DateTime? _date;

  Widget buildTimeList() {
    return SingleChildScrollView(
      child: times.length != 0
          ? Column(
              children: [
                ...List.generate(
                  times.length,
                  (index) => Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      // color: Colors.yellow,
                      child: Text(
                        '',
                        style: TextStyle(fontSize: 24),
                      ),
                    ),
                  ),
                ),
              ],
            )
          : SizedBox(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'go hello WORLD',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          showTimeBooked(context),
          showTimeBooked(context),
          showTimeBooked(context),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: RoundedButton(
                text: 'book',
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (context) => CustomDialogDatetimePicker());
                }),
          ),
        ],
      ),
    );
  }

  Padding showTimeBooked(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: sized(context).height * 0.08,
        decoration: BoxDecoration(
          // border: Border.all(width: 2,color: Colors.black12),
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 7,
              offset: Offset(0, 5), // changes position of shadow
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Icon(
              // Icons.bookmarks_sharp,
              Icons.event_busy,
              color: Colors.pink,
              size: 24.0,
            ),
            Container(
              decoration: BoxDecoration(),
              padding: EdgeInsets.all(8),
              child: Text(
                '11/12/2020',
                style: TextStyle(fontSize: 18),
              ),
            ),
            Container(
              padding: EdgeInsets.all(8),
              child: Text(
                '23:44 - 23:00',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
