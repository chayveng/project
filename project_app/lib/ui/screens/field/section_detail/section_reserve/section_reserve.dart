import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_app/core/apis/ApiConnect.dart';
import 'package:project_app/core/models/Time.dart';
import 'package:project_app/core/services/TimeService.dart';
import 'package:project_app/core/services/UserService.dart';
import 'package:project_app/ui/screens/field/components/title_bar.dart';
import 'package:project_app/ui/screens/field/section_detail/section_reserve/components/alert_dialog_accept.dart';
import 'package:project_app/ui/screens/field/section_detail/section_times/components/alert_dialog_delete.dart';
import 'package:project_app/ui/screens/field/section_detail/section_times/components/alert_dialog_info.dart';
import 'package:project_app/ui/screens/field/section_detail/section_times/components/bottom_sheet_booking.dart';
import 'package:project_app/ui/screens/field/section_detail/section_times/components/card_time.dart';

import 'components/alert_dialog_fail.dart';
import 'components/alert_dialog_success.dart';

class SectionReserve extends StatefulWidget {
  final bool? isOwner;
  final int? fieldId;
  final bool? isReserve;

  const SectionReserve({Key? key, this.isOwner, this.fieldId, this.isReserve})
      : super(key: key);

  @override
  _SectionReserveState createState() => _SectionReserveState();
}

class _SectionReserveState extends State<SectionReserve> {
  List<Time> times = [];
  List<Time> timesNotAccept = [];

  @override
  void initState() {
    fetchTimes();
    super.initState();
  }

  void fetchTimes() async {
    times.clear();
    timesNotAccept.clear();
    times = await TimeService.findByFieldId(widget.fieldId!);
    for (int i = 0; i < times.length; i++) {
      if (times[i].status == false) {
        timesNotAccept.add(times[i]);
      }
    }
    print('times not accept = ${timesNotAccept.length}');
    setState(() {});
    print(times.length);
  }

  _onAccept(Time time) async {
    time.status = true;
    // print(time);
    bool? callBack = await showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => AlertDialogAccept(
        startTime: time.startTime!,
        endTime: time.endTime!,
        onAccept: () async => Navigator.pop(
          context,
          await TimeService.createAccept(time),
        ),
      ),
    );
    if (callBack != null)
      var object = callBack
        ? showDialog(
        context: context,
        builder: (context) => DialogSuccess(),
      )
          : showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) => AlertDialogFail(),
      );
    fetchTimes();
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

  Padding buildCardTime(Time time) {
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: CardTime(
        isOwner: widget.isOwner,
        isReserve: widget.isReserve,
        startTime: timeGetTime(time.startTime!),
        endTime: timeGetTime(time.endTime!),
        date: timeGetDate(time.startTime!),
        onInfo: () async => _onInfo(time),
        onDelete: () async => await _onDelete(time),
        // onAccept: () async => await _onAccept(time),
        // onAccept: () async => await _onAcceptDialog(time),
        onAccept: () async => await _onAccept(time),
      ),
    );
  }

  Widget sectionTimes() {
    return Column(
      children: [
        ...List.generate(
          timesNotAccept.length,
          (index) => buildCardTime(timesNotAccept[index]),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, left: 8.0, right: 8.0),
      child: Container(
        padding: EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            TitleBar(title: 'การจอง', icon: Icons.alarm_rounded),
            sectionTimes(),
          ],
        ),
      ),
    );
  }
}
