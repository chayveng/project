import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_app/constants.dart';
import 'package:project_app/core/models/Time.dart';
import 'package:project_app/ui/components/rounded_button.dart';
import 'package:project_app/ui/screens/field/section_times/components/card_time.dart';
import 'components/bottom_sheet_booking.dart';

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
  DateTime? _date;

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
                        '',
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
      color: greyColor,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'เวลาที่ถูกจองแล้ว',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            CardTime(date: '21-7-2021',startTime: '19:00',endTime: '20:00',isOwner: true,),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: RoundedButton(
                  text: 'จอง',
                  onTap: () {
                    showCupertinoModalPopup(
                        context: context,
                        builder: (context) => BottomSheetBooking());
                    // showDialog(
                    //     context: context,
                    //     builder: (context) => CustomDialogDatetimePicker());
                  }),
            ),
          ],
        ),
      ),
    );
  }

}
