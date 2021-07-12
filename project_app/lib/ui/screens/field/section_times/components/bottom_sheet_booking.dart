import 'package:flutter/material.dart';
import 'package:flutter_rounded_date_picker/flutter_rounded_date_picker.dart';
import 'package:intl/intl.dart';
import 'package:project_app/ui/components/rounded_button.dart';

import '../../../../../constants.dart';

class BottomSheetBooking extends StatefulWidget {
  const BottomSheetBooking({Key? key}) : super(key: key);

  @override
  _BottomSheetBookingState createState() => _BottomSheetBookingState();
}

class _BottomSheetBookingState extends State<BottomSheetBooking> {
  final Map _time = {
    'hour': List.generate(24, (index) => index),
    'min': List.generate(6, (index) => index * 10),
  };
  Map _current = {'startHour': 0, 'startMin': 0, 'endHour': 0, 'endMin': 0};
  DateTime? startTime;
  DateTime? endTime;

  final DateTime _now = DateTime.now();

  @override
  void initState() {
    setState(() {
      var now = DateTime.now();
      startTime = DateTime(now.year, now.month, now.day);
      endTime = DateTime(now.year, now.month, now.day);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: sized(context).width,
      height: sized(context).height * 0.4,
      child: ClipRRect(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30), topRight: Radius.circular(30)),
        child: Material(
          color: whiteColor,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                onTap: () {
                  onPickDate(context);
                },
                child: Container(
                  height: 60,
                  width: 150,
                  decoration: BoxDecoration(
                    color: whiteColor,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(width: 2, color: orangePrimaryColor),
                  ),
                  child: Center(
                    child: Text(
                      '${DateFormat('dd-MM-yyyy').format(startTime!)}',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(width: 2, color: orangePrimaryColor),
                    ),
                    child: Row(
                      children: [
                        spinnerStartHour(),
                        SizedBox(width: 5),
                        Text(':', style: TextStyle(fontSize: 20)),
                        SizedBox(width: 5),
                        spinnerStartMin(),
                      ],
                    ),
                  ),
                  SizedBox(width: 5),
                  Text('ถึง', style: TextStyle(fontSize: 20)),
                  SizedBox(width: 5),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(width: 2, color: orangePrimaryColor),
                    ),
                    child: Row(
                      children: [
                        spinnerEndHour(),
                        SizedBox(width: 5),
                        Text(':', style: TextStyle(fontSize: 20)),
                        SizedBox(width: 5),
                        spinnerEndMin(),
                      ],
                    ),
                  ),
                  // spinnerStartHour(),
                  // SizedBox(width: 5),
                  // Text(':', style: TextStyle(fontSize: 20)),
                  // SizedBox(width: 5),
                  // spinnerStartMin(),
                  // SizedBox(width: 5),
                  // Text('ถึง', style: TextStyle(fontSize: 20)),
                  // SizedBox(width: 5),
                  // spinnerEndHour(),
                  // SizedBox(width: 5),
                  // Text(':', style: TextStyle(fontSize: 20)),
                  // SizedBox(width: 5),
                  // spinnerEndMin(),
                ],
              ),
              SizedBox(height: 15),
              Container(
                width: sized(context).width * 0.5,
                child: RoundedButton(
                    text: 'ยืนยัน',
                    onTap: () {
                      _getDateTime();
                    }),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _getDateTime() {
    return setState(() {
      var now = DateTime.now();
      String start = '${getDate(now)} ${getTime(
        _time['hour'][_current['startHour']],
        _time['min'][_current['startMin']],
      )}';
      String end = '${getDate(now)} ${getTime(
        _time['hour'][_current['endHour']],
        _time['min'][_current['endMin']],
      )}';
      startTime = DateTime.parse(start);
      endTime = DateTime.parse(end);
      print(startTime);
      print(endTime);
    });
  }

  Container spinnerStartHour() {
    return Container(
      decoration: BoxDecoration(
        color: whiteColor,
        borderRadius: BorderRadius.circular(10),
        // border: Border.all(width: 2, color: orangePrimaryColor),
      ),
      height: 100,
      width: 50,
      child: PageView.builder(
        controller: PageController(viewportFraction: 0.3),
        onPageChanged: (index) {
          setState(() {
            _current['startHour'] = index;
          });
        },
        scrollDirection: Axis.vertical,
        pageSnapping: true,
        itemCount: _time['hour'].length,
        itemBuilder: (BuildContext context, int index) => Center(
          child: Text(
            setText(_time['hour'][index]),
            style: TextStyle(
                color: _current['startHour'] == index
                    ? Colors.black
                    : Colors.black38),
          ),
        ),
      ),
    );
  }

  Container spinnerStartMin() {
    return Container(
      decoration: BoxDecoration(
        color: whiteColor,
        borderRadius: BorderRadius.circular(10),
        // border: Border.all(width: 2, color: orangePrimaryColor),
      ),
      height: 100,
      width: 50,
      child: PageView.builder(
        controller: PageController(viewportFraction: 0.3),
        onPageChanged: (index) {
          setState(() {
            _current['startMin'] = index;
          });
        },
        scrollDirection: Axis.vertical,
        pageSnapping: true,
        itemCount: _time['min'].length,
        itemBuilder: (BuildContext context, int index) => Center(
          child: Text(
            setText(_time['min'][index]),
            style: TextStyle(
                color: _current['startMin'] == index
                    ? Colors.black
                    : Colors.black38),
          ),
        ),
      ),
    );
  }

  Container spinnerEndHour() {
    return Container(
      decoration: BoxDecoration(
        color: whiteColor,
        borderRadius: BorderRadius.circular(10),
        // border: Border.all(width: 2, color: orangePrimaryColor),
      ),
      height: 100,
      width: 50,
      child: PageView.builder(
        controller: PageController(viewportFraction: 0.3),
        onPageChanged: (index) {
          setState(() {
            _current['endHour'] = index;
          });
        },
        scrollDirection: Axis.vertical,
        pageSnapping: true,
        itemCount: _time['hour'].length,
        itemBuilder: (BuildContext context, int index) => Center(
          child: Text(
            setText(_time['hour'][index]),
            style: TextStyle(
                color: _current['endHour'] == index
                    ? Colors.black
                    : Colors.black38),
          ),
        ),
      ),
    );
  }

  Container spinnerEndMin() {
    return Container(
      decoration: BoxDecoration(
        color: whiteColor,
        borderRadius: BorderRadius.circular(10),
        // border: Border.all(width: 2, color: orangePrimaryColor),
      ),
      height: 100,
      width: 50,
      child: PageView.builder(
        controller: PageController(viewportFraction: 0.3),
        onPageChanged: (index) {
          setState(() {
            _current['endMin'] = index;
          });
        },
        scrollDirection: Axis.vertical,
        pageSnapping: true,
        itemCount: _time['min'].length,
        itemBuilder: (BuildContext context, int index) => Center(
          child: Text(
            setText(_time['min'][index]),
            style: TextStyle(
                color: _current['endMin'] == index
                    ? Colors.black
                    : Colors.black38),
          ),
        ),
      ),
    );
  }

  String setText(int value) {
    String data = value.toString();
    return data.length < 2 ? '0${value}' : value.toString();
  }

  String getTime(int h, int m) {
    return '${setText(h)}:${setText(m)}:00';
  }

  String getDate(DateTime date) {
    return DateFormat('yyyy-MM-dd').format(date);
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

  Future<DateTime?> pickDate(BuildContext context) async {
    // final initialDate = DateTime(DateTime.now().day - 1);
    final initialDate = DateTime.now();
    print(initialDate);
    print(startTime);
    final newDate = await showDatePicker(
      // final newDate = await showRoundedDatePicker(
      //   height: 300,
      context: context,
      initialDate: DateTime.now(),
      // initialDate: startTime ?? initialDate,
      // theme: ThemeData(primarySwatch: Colors.orange),
      firstDate: initialDate,
      lastDate: DateTime(DateTime.now().year + 5),
    );

    if (newDate == null) return null;
    return newDate;
  }
}
