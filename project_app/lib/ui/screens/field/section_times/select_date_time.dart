import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:project_app/constants.dart';
import 'package:project_app/core/models/Time.dart';
import 'package:project_app/ui/components/custom_alert_dialog.dart';
import 'package:project_app/ui/components/rounded_button.dart';
import 'package:project_app/ui/screens/field/section_times/form_picker_date.dart';
import 'package:project_app/ui/screens/field/section_times/form_picker_time.dart';

class SelectDateTime extends StatefulWidget {
  final List<Time>? times;

  const SelectDateTime({Key? key, this.times}) : super(key: key);

  @override
  _SelectDateTimeState createState() => _SelectDateTimeState();
}

class _SelectDateTimeState extends State<SelectDateTime> {
  DateTime? tester;
  DateTime? startTime;
  DateTime? endTime;
  Time _time = Time();
  List<Time> times = [];
  DateTime? _date;

  @override
  void initState() {
    setDefaultDate();
    print(startTime);
    super.initState();
  }

  String getTime(DateTime time) {
    return DateFormat('HH:mm').format(time);
  }

  String getDate(DateTime date) {
    return DateFormat('dd/MM/yyyy').format(date);
  }

  String setFormTime(DateTime dateTime) {
    String hour = dateTime.hour.toString();
    String min = dateTime.minute.toString();
    return "${hour.length < 2 ? '0$hour' : '$hour'}:${min.length < 2 ? '0$min' : '$min'}";
  }

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
                child: Text(
                  '${setFormTime(times[index].startTime!)} - ${setFormTime(times[index].endTime!)}',
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
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Select time.',
                style: TextStyle(fontSize: 22),
              ),
            ),
            Center(
              child: FormPickerDate(
                onTap: () {
                  onPickDate(context);
                },
                dateStr: getDate(startTime!),
              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: FormPickerTime(
                    onTap: () {
                      onPickTimeStart();
                    },
                    timeStr: getTime(startTime!),
                  ),
                ),
                Text('ถึง'),
                Expanded(
                  child: FormPickerTime(
                    onTap: () {
                      onPickTimeEnd();
                    },
                    timeStr: getTime(endTime!),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            RoundedButton(
              text: 'Book',
              onTap: () {
                onBooking();
              },
            ),
          ],
        ),
      ),
    );
  }

  Future onBooking() async {
    print('book');
    if (startTime != null && endTime != null) {
      print(startTime!);
      print(endTime!);
      if (endTime!.isAfter(startTime!)) {
        if (times.length == 0) {
          print('add first time');
          setState(() {
            _time.startTime = startTime;
            _time.endTime = endTime;
            times.add(_time);
          });
          print(times.length);
        } else {
          Time timeLast = times.last;
          if (timeLast.endTime!.isBefore(startTime!) ||
              timeLast.endTime == startTime!) {
            print('new time ok');
            Time newTime = Time();
            newTime.startTime = startTime;
            newTime.endTime = endTime;
            print(newTime);
            setState(() {
              times.add(newTime);
            });
            print(times.length);
            await showDialog(
              context: context,
              builder: (context) => CustomAlertDialog(
                title: 'Booked',
                content: 'Bookeddd',
                onConfirm: () => Navigator.pop(context),
              ),
            ) ??
                Navigator.pop(context);
          } else {
            print('new time not ok');
            showDialog(
              context: context,
              builder: (context) => CustomAlertDialog(
                title: 'Error',
                content:
                'Please select another time Because it has been booked.',
                onConfirm: () {
                  Navigator.pop(context);
                },
              ),
            );
          }
        }
        print('select time is ok');
      } else {
        print('start > end');
        showDialog(
          context: context,
          builder: (context) => CustomAlertDialog(
            title: 'Error',
            content: 'start time is greater than end time, Please try again',
            onConfirm: () {
              Navigator.pop(context);
            },
          ),
        );
      }
    } else {
      print('time is null');
    }
  }

  Future setDefaultDate() async {
    final currentDate = DateTime.now();
    _date = currentDate;
    setState(() {
      startTime = DateTime(
        currentDate.year,
        currentDate.month,
        currentDate.day,
      );
      endTime = DateTime(
        currentDate.year,
        currentDate.month,
        currentDate.day,
      );
      print(_date);
    });
  }

  Future onPickDate(BuildContext context) async {
    final date = await pickDate(context);
    if (date == null) return;

    setState(() {
      startTime = DateTime(
        date.year,
        date.month,
        date.day,
      );
      endTime = DateTime(
        date.year,
        date.month,
        date.day,
      );
    });
    print(startTime);
    print(endTime);
  }

  Future onPickTimeStart() async {
    final time = await pickTime(context);
    if (time == null) return;
    setState(() {
      startTime = DateTime(startTime!.year, startTime!.month, startTime!.day,
          time.hour, time.minute);
    });
    print(time);
    print(startTime);
  }

  Future onPickTimeEnd() async {
    final time = await pickTime(context);
    if (time == null) return;
    setState(() {
      endTime = DateTime(
          endTime!.year, endTime!.month, endTime!.day, time.hour, time.minute);
    });
    print(time);
    print(endTime);
  }

  Future<DateTime?> pickDate(BuildContext context) async {
    final initialDate = DateTime.now();
    final newDate = await showDatePicker(
      context: context,
      initialDate: startTime ?? initialDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(DateTime.now().year + 5),
    );

    if (newDate == null) return null;
    // print(newDate);
    return newDate;
  }

  Future<TimeOfDay?> pickTime(BuildContext context) async {
    final initialTime = TimeOfDay(hour: 0, minute: 0);
    final newTime = await showTimePicker(
      initialEntryMode: TimePickerEntryMode.input,
      context: context,
      initialTime: initialTime,
      // initialTime: startTime != null
      //     ? TimeOfDay(hour: startTime!.hour, minute: startTime!.minute)
      //     : initialTime,
      builder: (BuildContext context, Widget? child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
          child: child!,
        );
      },
    );

    if (newTime == null) return null;
    // print(newTime);
    return newTime;
  }
}
