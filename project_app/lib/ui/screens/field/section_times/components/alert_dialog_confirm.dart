import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:project_app/core/models/Time.dart';

import '../../../../../constants.dart';

class DialogConfirm extends StatelessWidget {
  final Time? time;
  final GestureTapCallback? onTap;
  final DateTime? startTime;
  final DateTime? endTime;


  const DialogConfirm({Key? key, this.time, this.onTap, this.startTime, this.endTime,}) : super(key: key);

  Widget footer(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Expanded(
          child: InkWell(
            onTap: onTap,
            child: Container(
              height: 45,
              decoration: BoxDecoration(
                color: orangeColor.withOpacity(0.1),
                border: Border(
                  right: BorderSide(width: 1, color: orangeColor),
                  top: BorderSide(width: 1, color: orangeColor),
                ),
              ),
              child: Center(
                child: Text(
                  'ยืนยัน',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: InkWell(
            onTap: () => Navigator.pop(context),
            child: Container(
              height: 45,
              decoration: BoxDecoration(
                color: orangeColor.withOpacity(0.1),
                border: Border(
                  top: BorderSide(width: 1, color: orangeColor),
                ),
              ),
              child: Center(
                child: Text(
                  'ยกเลิก',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  String getTime(){
   var _startTime = DateFormat('HH:mm').format(startTime!);
   var _endTime = DateFormat('HH:mm').format(endTime!);
    return '${_startTime} - ${_endTime}';
  }

  Widget content() {
    return Text(
      'เวลา  ${getTime()}',
      style: TextStyle(fontSize: 16),
    );
  }

  Widget title() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        'ยืนยันการจอง',
        style: TextStyle(fontSize: 20, color: orangeColor),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          title(),
          content(),
          SizedBox(height: 15),
          footer(context),
        ],
      ),
    );
  }
}
