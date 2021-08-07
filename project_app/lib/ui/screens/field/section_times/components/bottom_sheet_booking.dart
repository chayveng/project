import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:project_app/constants.dart';
import 'package:project_app/core/models/Time.dart';
import 'package:project_app/core/services/TimeService.dart';
import 'package:project_app/core/services/UserService.dart';
import 'package:project_app/ui/screens/field/section_times/components/alert_dialog_confirm.dart';
import 'package:project_app/ui/screens/field/section_times/components/alert_dialog_delete.dart';
import 'package:project_app/ui/screens/field/section_times/components/alert_dialog_info.dart';

import 'package:project_app/ui/screens/field/section_times/components/button_booking.dart';
import 'package:project_app/ui/screens/field/section_times/components/custom_colon.dart';

import 'alert_dialog_fail.dart';

class BottomSheetBooking extends StatefulWidget {
  final List? times;
  final int? fieldId;
  final int? userId;

  const BottomSheetBooking({Key? key, this.times, this.fieldId, this.userId})
      : super(key: key);

  @override
  _BottomSheetBookingState createState() => _BottomSheetBookingState();
}

class _BottomSheetBookingState extends State<BottomSheetBooking> {
  final Map _time = {
    'hour': List.generate(24, (index) => index),
    'min': List.generate(60, (index) => index * 10),
  };
  Map _current = {'startHour': 0, 'startMin': 0, 'endHour': 0, 'endMin': 0};
  DateTime currentTime = DateTime.now();
  DateTime? startTime, endTime;
  Time time = new Time();

  String setTowBit(int value) =>
      value.toString().length < 2 ? '0$value' : value.toString();

  String getDateTime(DateTime dateTime) =>
      DateFormat('yyyy-MM-dd HH:mm').format(dateTime);

  String getTime(DateTime time) => DateFormat('HH:mm').format(time);

  String getDate(DateTime date) => DateFormat('dd-MM-yyyy').format(date);

  _onBooking() async {
    print('booking');
    _setTime();
    print(time);
    if (startTime!.isBefore(endTime!)) {
      bool? res = await showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) => DialogConfirm(
          startTime: startTime,
          endTime: endTime,
          onTap: () async {
            if (await TimeService.create(time)) {
              Navigator.pop(context, true);
            } else {
              bool res = await showDialog(
                barrierDismissible: false,
                context: context,
                builder: (context) => AlertDialogFail(),
              );
              if (res) {
                Navigator.pop(context);
              }
            }
          },
        ),
      );
      if (res != null) {
        Navigator.pop(context);
      }
      print('success');
      // Navigator.pop(context);
    } else {
      print('fail');
      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) => AlertDialogFail(),
      );
    }
  }

  _setTime() {
    // int userId = await UserService.getUserId();
    setState(() {
      startTime = DateTime(
        currentTime.year,
        currentTime.month,
        currentTime.day,
        _time['hour'][_current['startHour']],
        _time['min'][_current['startMin']],
      );
      endTime = DateTime(
        currentTime.year,
        currentTime.month,
        currentTime.day,
        _time['hour'][_current['endHour']],
        _time['min'][_current['endMin']],
      );
      time.fieldId = widget.fieldId;
      time.userId = widget.userId;
      time.startTime = getDateTime(startTime!);
      time.endTime = getDateTime(endTime!);
    });
  }

  Future<void> _selectDate(BuildContext context) async {
     DateTime? pickedDate = (await showDatePicker(
        context: context,
        initialDate: currentTime,
        firstDate: DateTime.now(),
        lastDate: DateTime(2050),
        builder: (context, child) {
          return Theme(
              data: ThemeData.light().copyWith(
                colorScheme: ColorScheme.light(
                  primary: Colors.orangeAccent.withOpacity(0.9),
                ),
              ),
              child: child!);
        }));
    if (pickedDate != null)
      setState(() {
        currentTime = pickedDate;
      });
    print(currentTime);
  }

  // _onDate() {
  //   print('select date');
  //   showDatePicker(
  //     context: context,
  //     initialDate: DateTime.now(),
  //     firstDate: DateTime.now(),
  //     lastDate: DateTime(2030),
  //     builder: (context, child) {
  //       return Theme(
  //           data: ThemeData.light().copyWith(
  //             colorScheme: ColorScheme.light(
  //               primary: Colors.orangeAccent.withOpacity(0.9),
  //             ),
  //           ),
  //           child: child!);
  //     },
  //   );
  // }

  Widget spinner({
    @required String? time,
    @required String? current,
  }) {
    return Container(
      width: 33,
      height: 100,
      child: PageView.builder(
        pageSnapping: true,
        controller: PageController(
          initialPage: _current[current],
          viewportFraction: 0.37,
        ),
        scrollDirection: Axis.vertical,
        itemCount: _time[time].length,
        onPageChanged: (index) => setState(() => _current[current] = index),
        itemBuilder: (BuildContext context, int index) {
          return Center(
            child: Text(
              setTowBit(_time[time][index]),
              style: TextStyle(
                fontSize: 22,
                color:
                    _current[current] == index ? Colors.black : Colors.black38,
              ),
            ),
          );
        },
      ),
    );
  }

  Widget formDate() {
    return Container(
      padding: EdgeInsets.all(6),
      decoration: BoxDecoration(
          color: orangePrimaryColor.withOpacity(0.5),
          border: Border.all(width: 2, color: orangePrimaryColor),
          borderRadius: BorderRadius.circular(8)),
      child: InkWell(
        onTap: () {
          print('select date');
          _selectDate(context);
        },
        child: Text(
          DateFormat('dd-MM-yyyy').format(currentTime),
          style: TextStyle(fontSize: 16),
        ),
      ),
    );
  }

  Widget formEnd() {
    return Container(
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        border: Border.all(width: 2, color: orangePrimaryColor),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          spinner(time: 'hour', current: 'endHour'),
          CustomColon(size: 3.5),
          spinner(time: 'min', current: 'endMin'),
        ],
      ),
    );
  }

  Widget formStart() {
    return Container(
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        border: Border.all(width: 2, color: orangePrimaryColor),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          spinner(time: 'hour', current: 'startHour'),
          CustomColon(size: 3.5),
          spinner(time: 'min', current: 'startMin')
        ],
      ),
    );
  }

  Widget sectionBooking(BuildContext context) {
    return Column(
      children: [
        Text('จอง', style: TextStyle(fontSize: 24)),
        SizedBox(height: 8),
        formDate(),
        SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            formStart(),
            SizedBox(width: 8),
            Text('ถึง'),
            SizedBox(width: 8),
            formEnd(),
          ],
        ),
        ButtonBooking(onTap: () async => await _onBooking()),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(20),
        topRight: Radius.circular(20),
      ),
      child: Material(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            sectionBooking(context),
            Container(
              color: Colors.redAccent,
              child: SafeArea(
                bottom: true,
                child: SizedBox(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
