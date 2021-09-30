import 'package:flutter/material.dart';
import 'package:project_app/core/models/Time.dart';

import '../../../../../../constants.dart';


class AlertDialogDelete extends StatelessWidget {
  final Time? time;
  final GestureTapCallback? onDelete;

  const AlertDialogDelete({Key? key, this.onDelete, this.time})
      : super(key: key);

  Widget footer(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Expanded(
          child: InkWell(
            onTap: onDelete,
            child: Container(
              width: sized(context).width * 0.4,
              height: 45,
              decoration: BoxDecoration(
                color: orangeColor.withOpacity(0.1),
                border: Border(
                  right: BorderSide(width: 1, color: orangeColor),
                  top: BorderSide(width: 1, color: orangeColor),
                ),
              ),
              child: Center(
                child: Text('ยืนยัน',style: TextStyle(fontSize: 16)),
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
                  left: BorderSide(width: 1, color: orangeColor),
                ),
              ),
              child: Center(
                child: Text('ยกเลิก', style: TextStyle(fontSize: 16)),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget content() {
    return Text(
      '${timeGetTime(time!.startTime!)} - ${timeGetTime(time!.endTime!)}',
      style: TextStyle(fontSize: 18),
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
