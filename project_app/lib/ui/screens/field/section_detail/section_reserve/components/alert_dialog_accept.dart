import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:project_app/core/models/Time.dart';

import '../../../../../../constants.dart';

class AlertDialogAccept extends StatelessWidget {
  final String? startTime;
  final String? endTime;
  final GestureTapCallback? onAccept;

  const AlertDialogAccept({
    Key? key,
    this.startTime,
    this.endTime,
    this.onAccept,
  }) : super(key: key);

  getTime(DateTime time) => DateFormat('HH:mm').format(time);

  Expanded confirmBtn() {
    return Expanded(
      child: InkWell(
        onTap: onAccept,
        child: Container(
          height: 45,
          decoration: BoxDecoration(
            color: orangeColor.withOpacity(0.1),
            border: Border(
              top: BorderSide(width: 1, color: orangeColor),
            ),
          ),
          child: Center(
            child: Text('ยืนยัน', style: TextStyle(fontSize: 16)),
          ),
        ),
      ),
    );
  }

  Expanded cancelBtn(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: () => Navigator.pop(context),
        child: Container(
          height: 45,
          decoration: BoxDecoration(
            color: orangeColor.withOpacity(0.1),
            border: Border(
              top: BorderSide(width: 1, color: orangeColor),
              left: BorderSide(width: 1, color: orangeColor),
            ),
          ),
          child: Center(
            child: Text('ยกเลิก', style: TextStyle(fontSize: 16)),
          ),
        ),
      ),
    );
  }

  Widget footer(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        confirmBtn(),
        cancelBtn(context),
      ],
    );
  }

  Widget content() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'วันที่: ${timeGetDate(startTime!)}',
          style: TextStyle(fontSize: 18),
        ),
        Text(
          'เวลา: ${timeGetTime(startTime!)} - ${timeGetTime(endTime!)}',
          style: TextStyle(fontSize: 18),
        ),
      ],
    );
  }

  Widget title() {
    return Text(
      'ยืนยันการจอง',
      style: TextStyle(fontSize: 20, color: orangeColor),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: 8),
          title(),
          content(),
          SizedBox(height: 15),
          footer(context),
        ],
      ),
    );
  }
}
