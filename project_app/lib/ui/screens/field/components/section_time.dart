import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:project_app/constants.dart';
import 'package:project_app/core/models/Time.dart';
import 'package:project_app/ui/components/custom_alert_dialog.dart';
import 'package:project_app/ui/components/rounded_button.dart';

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

  String getText1(DateTime? time, String? defaultText) {
    if (time == null) {
      return defaultText!;
    } else {
      return DateFormat('dd/MM/yyyy HH:mm').format(time);
    }
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
                      // color: Colors.yellow,
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
    return Container(
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 20),
            // buildTimeList(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  width: 150,
                  child: RoundedButton(
                      text: getText1(startTime, 'Start time'),
                      onTap: () {
                        pickDateTime1(context);
                      }),
                ),
                Text('ถึง'),
                Container(
                  width: 150,
                  child: RoundedButton(
                      text: getText1(endTime, 'End time'),
                      onTap: () {
                        pickDateTime2(context);
                      }),
                ),
              ],
            ),
            SizedBox(height: 20),
            Container(
              width: 200,
              child: RoundedButton(
                text: 'Book',
                onTap: () {
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
                          content:
                              'start time is greater than end time, Please try again',
                          onConfirm: () {
                            Navigator.pop(context);
                          },
                        ),
                      );
                    }
                  } else {
                    print('time is null');
                  }
                },
              ),
            ),
            // ElevatedButton(
            //   onPressed: () {
            //     for (var i = 0; i < times.length; i++) {
            //       print(
            //           '$i start: ${times[i].startTime} => ${times[i].endTime}');
            //     }
            //   },
            //   child: Text('print'),
            // ),
            // ElevatedButton(
            //   onPressed: () {
            //     setState(() {
            //       times.clear();
            //     });
            //     print(times);
            //   },
            //   child: Text('clear'),
            // ),
            buildTimeList(),
          ],
        ),
      ),
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
      _time.endTime = endTime;
      endTime = DateTime(
        date.year,
        date.month,
        date.day,
        time.hour,
        time.minute,
      );
    });
  }

  Future<DateTime?> pickDate1(BuildContext context) async {
    final initialDate = DateTime.now();
    final newDate = await showDatePicker(
      context: context,
      initialDate: startTime ?? initialDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(DateTime.now().year + 5),
      // firstDate: DateTime(DateTime.now().year - 5),
      // lastDate: DateTime(DateTime.now().year + 5),
    );

    if (newDate == null) return null;
    // print(newDate);
    return newDate;
  }

  Future<DateTime?> pickDate2(BuildContext context) async {
    final initialDate = DateTime.now();
    final newDate = await showDatePicker(
      context: context,
      initialDate: endTime ?? initialDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(DateTime.now().year + 5),
      // firstDate: DateTime(DateTime.now().year - 5),
      // lastDate: DateTime(DateTime.now().year + 5),
    );
    if (newDate == null) return null;
    // print(newDate);
    return newDate;
  }

  Future<TimeOfDay?> pickTime1(BuildContext context) async {
    final initialTime = TimeOfDay(hour: 0, minute: 0);
    final newTime = await showTimePicker(
      initialEntryMode: TimePickerEntryMode.input,
      context: context,
      initialTime: startTime != null
          ? TimeOfDay(hour: startTime!.hour, minute: startTime!.minute)
          : initialTime,
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

  Future<TimeOfDay?> pickTime2(BuildContext context) async {
    final initialTime = TimeOfDay(hour: 0, minute: 0);
    final newTime = await showTimePicker(
      initialEntryMode: TimePickerEntryMode.input,
      context: context,
      initialTime: endTime != null
          ? TimeOfDay(hour: startTime!.hour, minute: startTime!.minute)
          : initialTime,
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
