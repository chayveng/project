import 'package:flutter/material.dart';
import 'package:project_app/core/models/Time.dart';
import 'package:project_app/ui/screens/club/components/sectionFieldTime/card_time.dart';
import 'package:project_app/ui/screens/club/components/dialog_time_picker.dart';

import '../../../../../constants.dart';

class SectionTime extends StatefulWidget {
  final bool isOwner;
  final bool status;
  final int fieldId;
  final int clubId;
  final List<Time> times;

  const SectionTime({
    Key key,
    @required this.isOwner,
    @required this.status,
    @required this.fieldId,
    @required this.clubId,
    @required this.times,
  }) : super(key: key);

  @override
  _SectionTimeState createState() => _SectionTimeState();
}

class _SectionTimeState extends State<SectionTime> {
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      color: Colors.transparent,
      height: widget.status ? 200 : 0,
      width: sized(context).width,
      duration: Duration(milliseconds: 100),
      child: widget.status == true ? _listSection(context) : SizedBox(),
    );
  }

  Widget _listSection(BuildContext context) {
    Time _time = Time(
      status: true,
      startTime: '11:00',
      endTime: '12:00',
      fieldId: 1,
      userId: 1,
    );
    return SingleChildScrollView(
      child: Column(
        children: [
          CardTime(isOwner: true, time: _time),
          CardTime(isOwner: true, time: _time),

          // ...List.generate(
          //   widget.times.length,
          //   (index) => CardTime(
          //     isOwner: widget.isOwner,
          //     time: widget.times[index],
          //   ),
          // ),
          widget.isOwner
              ? IconButton(
                  icon: Icon(Icons.add_circle_outline_rounded),
                  onPressed: () async {
                    var result = await showDialog<bool>(
                      context: context,
                      builder: (context) => DialogTimePicker(
                        fieldId: widget.fieldId,
                        clubId: widget.clubId,
                      ),
                    );
                  },
                )
              : SizedBox(),
        ],
      ),
    );
  }
}
