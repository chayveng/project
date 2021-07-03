import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CardTime extends StatelessWidget {
  final DateTime? startTime;
  final DateTime? endTime;

  const CardTime({Key? key, this.startTime, this.endTime}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Container(
        padding: EdgeInsets.all(8),
        color: Colors.yellow,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            formDate(),
            formTime(),
          ],
        ),
      ),
    );
  }

  Widget formTime() => Row(
        children: [
          Icon(Icons.timer),
          SizedBox(width: 10),
          Text(
            '${getTime(startTime!)} - ${getTime(endTime!)}',
            // '12:00 - 23:00',
            style: TextStyle(
              fontSize: 18,
            ),
          ),
        ],
      );

  Widget formDate() => Row(
        children: [
          Icon(Icons.calendar_today_rounded),
          SizedBox(width: 10),
          Text(
            '${getDate(startTime!)}',
            // '12/05/2020',
            style: TextStyle(
              color: Colors.black38,
            ),
          ),
        ],
      );

  String getDate(DateTime dateTime) {
    return DateFormat('dd-MM-yyyy').format(dateTime);
  }

  String getTime(DateTime dateTime) {
    return DateFormat('HH:mm').format(dateTime);
  }
}
