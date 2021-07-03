import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_app/constants.dart';
import 'package:project_app/ui/screens/field/section_times/components/card_time.dart';
import 'package:project_app/ui/screens/field/section_times/components/form_booking.dart';
import 'package:project_app/ui/screens/field/section_times/neo_select_time/bottom_sheet_booking.dart';

class SectionTime extends StatefulWidget {
  const SectionTime({Key? key}) : super(key: key);

  @override
  _SectionTimeState createState() => _SectionTimeState();
}

class _SectionTimeState extends State<SectionTime> {
  DateTime start = DateTime.parse('2021-07-03 11:44');
  DateTime end = DateTime.parse('2021-07-03 15:50');

  Padding buildCardTime(DateTime start, DateTime end) {
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: CardTime(startTime: start, endTime: end),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        children: [
          ElevatedButton(
            onPressed: () {
              showCupertinoModalPopup(
                context: context,
                builder: (context) => BottomSheetBooking(),
              );
            },
            child: Text(''),
          ),
          buildCardTime(start, end),
          buildCardTime(start, end),
          buildCardTime(start, end),
          buildCardTime(start, end),
          buildCardTime(start, end),
          buildCardTime(start, end),
          buildCardTime(start, end),
        ],
      ),
    );
  }
}
