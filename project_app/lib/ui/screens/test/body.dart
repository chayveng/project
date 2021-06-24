import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:project_app/constants.dart';
import 'package:project_app/core/models/Time.dart';

import 'components/dialog_date_time_picker/dialog_date_time_picker.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  List<Time> data = [];
  DateTime? startTime, endTime;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: sized(context).width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          sectionTimes(),
          ElevatedButton(
            child: Text(startTime != null
                ? setStartToEnd(startTime!, endTime!)
                : 'Picker'),
            onPressed: () async => await onPicker(),
          ),
          ElevatedButton(
            child: Text('Booking'),
            onPressed: () async => await onBooking(),
          ),
          Container(
            child: Text(''),
          ),
        ],
      ),
    );
  }

  onBooking() {
    print('booking');
    if (startTime != null && endTime != null) {
      Time time = Time();
      time.startTime = startTime.toString();
      time.endTime = endTime.toString();
      data.add(time);
      startTime = null;
      endTime = null;
      setState(() {});
    }
  }

  onPicker() async {
    await showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => DialogDateTimePicker(
        startTime: startTime,
        endTime: endTime,
      ),
    ).then((value) {
      print(value);
      if (value != null) {
        setState(() {
          startTime = value['start'];
          endTime = value['end'];
        });
      }
    });
  }

  Widget sectionTimes() {
    return data.length != 0
        ? Column(
            children: [
              ...List.generate(
                data.length,
                (index) => Text(
                    '${getTime(data[index].startTime!)} - ${getTime(data[index].endTime!)}'),
                // Text('${data[index].startTime} - ${data[index].endTime}'),
              ),
            ],
          )
        : Text('null');
  }

  String getTime(String str) {
    int index = str.indexOf(' ');
    return str.substring(index + 1, index + 6);
  }

  String setStartToEnd(DateTime start, DateTime end) {
    return '${setFormTime(startTime!)} - ${setFormTime(endTime!)}';
  }

  String setFormDate(DateTime date) => DateFormat('dd/MM/yyyy').format(date);

  String setFormTime(DateTime time) => DateFormat('HH:mm').format(time);

  void printFormTime(DateTime start, DateTime end) {
    print('${setFormTime(start)} - ${setFormTime(end)}');
  }

  void printFormDate(DateTime start, DateTime end) {
    print('${setFormDate(start)} - ${setFormDate(end)}');
  }
}
