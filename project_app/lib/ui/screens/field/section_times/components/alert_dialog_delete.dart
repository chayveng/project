import 'package:flutter/material.dart';
import 'package:project_app/core/models/Time.dart';

import '../../../../../constants.dart';

class AlertDialogDelete extends StatelessWidget {
  final Time? time;
  final GestureTapCallback? onDelete;

  const AlertDialogDelete({Key? key, this.onDelete, this.time})
      : super(key: key);

  Widget footer(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        InkWell(
          onTap: onDelete,
          child: Container(
            width: sized(context).width * 0.4,
            height: sized(context).height * 0.04,
            decoration: BoxDecoration(
              color: orangeColor.withOpacity(0.1),
              border: Border(
                right: BorderSide(width: 1, color: orangeColor),
                top: BorderSide(width: 1, color: orangeColor),
              ),
            ),
            child: Center(
              child: Text('ยืนยัน'),
            ),
          ),
        ),
        InkWell(
          onTap: () => Navigator.pop(context),
          child: Container(
            width: sized(context).width * 0.4,
            height: sized(context).height * 0.04,
            decoration: BoxDecoration(
              color: orangeColor.withOpacity(0.1),
              border: Border(
                top: BorderSide(width: 1, color: orangeColor),
              ),
            ),
            child: Center(
              child: Text('ยกเลิก'),
            ),
          ),
        ),
      ],
    );
  }

  Widget content() {
    return Text(
      '${timeGetTime(time!.startTime!)} - ${timeGetTime(time!.endTime!)}',
      style: TextStyle(fontSize: 16),
    );
  }

  Widget title() {
    return Text(
      'ลบเวลา',
      style: TextStyle(fontSize: 20, color: orangeColor),
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
