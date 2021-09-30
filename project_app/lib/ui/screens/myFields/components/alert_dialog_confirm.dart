import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../constants.dart';


class AlertDialogConfirm extends StatelessWidget {
  final GestureTapCallback? onConfirm;
  final String? fieldName;

  const AlertDialogConfirm({
    Key? key,
    this.onConfirm,
   @required   this.fieldName,
  }) : super(key: key);

  Expanded confirmBtn() {
    return Expanded(
      child: InkWell(
        onTap: onConfirm,
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
        onTap: () => Navigator.pop(context, false),
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
    return Text('ต้องการที่จะลบสนาม: $fieldName');
    // return Text(
    //   '${getTime(startTime!)} - ${getTime(endTime!)}',
    //   style: TextStyle(fontSize: 18),
    // );
  }

  Widget title() {
    return Text(
      'ยืนยันการลบ',
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
