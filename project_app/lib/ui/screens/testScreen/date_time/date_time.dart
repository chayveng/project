import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:project_app/ui/screens/testScreen/date_time/button_widget.dart';

class DateTimePicker extends StatefulWidget {
  @override
  _DateTimePickerState createState() => _DateTimePickerState();
}

class _DateTimePickerState extends State<DateTimePicker> {
  DateTime startTime;
  DateTime endTime;

  String getText1() {
    if (startTime == null) {
      return 'Select DateTime';
    } else {
      return DateFormat('dd/MM/yyyy HH:mm').format(startTime);
    }
  }
  String getText2() {
    if (endTime == null) {
      return 'Select DateTime';
    } else {
      return DateFormat('dd/MM/yyyy HH:mm').format(endTime);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ButtonHeaderWidget(
          title: 'DateTime',
          text: getText1(),
          onClicked: () => pickDateTime1(context),
        ),
        ButtonHeaderWidget(
          title: 'DateTime',
          text: getText2(),
          onClicked: () => pickDateTime2(context),
        ),
        ElevatedButton(
          onPressed: () {
            // var dateTime1 = dateTime;
            // var dateTime2 = dateTime;
            // var sum = dateTime2.day - dateTime1.day;
            // print(sum);
            print(startTime);
            print(endTime);
            if(endTime.isAfter(startTime)){ //start < end
              print('time ok');
            }else{
              print('select new time');
            }
            if(endTime.isBefore(startTime)){
              print('ok');
            }else{
              print('no');
            }
          },
          child: Text('print'),
        ),
      ],
    );
  }

  Future pickDateTime1(BuildContext context) async {
    final date = await pickDate1(context);
    if (date == null) return;

    final time = await pickTime1(context);
    if (time == null) return;

    setState(() {
      startTime = DateTime(
        date.year,
        date.month,
        date.day,
        time.hour,
        time.minute,
      );
    });
  }

  Future pickDateTime2(BuildContext context) async {
    final date = await pickDate2(context);
    if (date == null) return;

    final time = await pickTime2(context);
    if (time == null) return;

    setState(() {
      endTime = DateTime(
        date.year,
        date.month,
        date.day,
        time.hour,
        time.minute,
      );
    });
  }

  Future<DateTime> pickDate1(BuildContext context) async {
    final initialDate = DateTime.now();
    final newDate = await showDatePicker(
      context: context,
      initialDate: startTime ?? initialDate,
      firstDate: DateTime(DateTime.now().year - 5),
      lastDate: DateTime(DateTime.now().year + 5),
    );

    if (newDate == null) return null;
    print(newDate);
    return newDate;
  }
  Future<DateTime> pickDate2(BuildContext context) async {
    final initialDate = DateTime.now();
    final newDate = await showDatePicker(
      context: context,
      initialDate: endTime ?? initialDate,
      firstDate: DateTime(DateTime.now().year - 5),
      lastDate: DateTime(DateTime.now().year + 5),
    );

    if (newDate == null) return null;
    print(newDate);
    return newDate;
  }

  Future<TimeOfDay> pickTime1(BuildContext context) async {
    final initialTime = TimeOfDay(hour: 9, minute: 0);
    final newTime = await showTimePicker(
      context: context,
      initialTime: startTime != null
          ? TimeOfDay(hour: startTime.hour, minute: startTime.minute)
          : initialTime,
    );

    if (newTime == null) return null;
    print(newTime);
    return newTime;
  }
  Future<TimeOfDay> pickTime2(BuildContext context) async {
    final initialTime = TimeOfDay(hour: 9, minute: 0);
    final newTime = await showTimePicker(
      context: context,
      initialTime: endTime != null
          ? TimeOfDay(hour: startTime.hour, minute: startTime.minute)
          : initialTime,
    );

    if (newTime == null) return null;
    print(newTime);
    return newTime;
  }
}
