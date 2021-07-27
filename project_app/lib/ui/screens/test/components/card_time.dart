import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:project_app/constants.dart';
import 'package:project_app/core/models/Time.dart';

class CardTime extends StatelessWidget {
  final Time? time;

  const CardTime({Key? key, this.time}) : super(key: key);

  String getDate() {
    DateTime date = DateTime.parse(time!.startTime!);
    return '${DateFormat('dd/MM/yyyy').format(date)}';
  }

  String getTime(String time) => DateFormat('HH:mm').format(DateTime.parse(time));

  String setTimeBetween() {
    return '${getTime(time!.startTime!)} - ${getTime(time!.endTime!)}';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: sized(context).width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(getDate()),
          Text(setTimeBetween()),
        ],
      ),
    );
  }
}
