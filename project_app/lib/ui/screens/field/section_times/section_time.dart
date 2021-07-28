import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_app/core/models/Time.dart';
import 'package:project_app/core/services/TimeService.dart';
import 'package:project_app/core/services/UserService.dart';
import 'package:project_app/ui/screens/field/section_times/components/alert_dialog_delete.dart';
import 'package:project_app/ui/screens/field/section_times/components/alert_dialog_info.dart';
import 'package:project_app/ui/screens/field/section_times/components/button_booking.dart';
import 'package:project_app/ui/screens/field/section_times/components/card_time.dart';
import 'package:project_app/ui/screens/field/section_times/components/bottom_sheet_booking.dart';

class SectionTime extends StatefulWidget {
  final bool? isOwner;
  final int? fieldId;

  const SectionTime({Key? key, this.isOwner, this.fieldId}) : super(key: key);

  @override
  _SectionTimeState createState() => _SectionTimeState();
}

class _SectionTimeState extends State<SectionTime> {
  List<Time> times = [];

  @override
  void initState() {
    fetchTimes();
    super.initState();
  }

  void fetchTimes() async {
    times.clear();
    times = await TimeService.findByFieldId(widget.fieldId!);
    setState(() {});
    print(times.length);
  }

  Future<void> _onDelete(Time time) async {
    print('on delete: timeId = ${time.id!}');
    await showDialog(
      context: context,
      builder: (context) => AlertDialogDelete(
        time: time,
        onDelete: () async {
          await TimeService.deleteById(time.id!);
          Navigator.pop(context);
        },
      ),
    ).then((value) => fetchTimes());
  }

  Future<void> _onInfo(Time time) async {
    print('on info: timeId = ${time.id!}');
    await showDialog(
      context: context,
      builder: (context) => AlertDialogInfo(time: time),
    ).then((value) => fetchTimes());
  }

  Future<void> _onBooking() async {
    int userId = await UserService.getUserId();
    await showCupertinoModalPopup(
      context: context,
      builder: (context) => BottomSheetBooking(
        fieldId: widget.fieldId,
        userId: userId,
      ),
    ).then((value) => fetchTimes());
  }

  Padding buildCardTime(Time time) {
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: CardTime(
        isOwner: widget.isOwner,
        startTime: timeGetTime(time.startTime!),
        endTime: timeGetTime(time.endTime!),
        date: timeGetDate(time.startTime!),
        onInfo: () async => _onInfo(time),
        onDelete: () async => await _onDelete(time),
      ),
    );
  }

  Widget sectionTimes() {
    return Container(
      child: Column(
        children: [
          ...List.generate(
            times.length,
            (index) => buildCardTime(times[index]),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        children: [
          ButtonBooking(onTap: _onBooking),
          sectionTimes(),
        ],
      ),
    );
  }
}
