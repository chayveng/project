import 'package:flutter/material.dart';
import 'package:project_app/core/models/Time.dart';

class AlertDialogDelete extends StatelessWidget {
  final Time? time;
  final GestureTapCallback? onDelete;

  const AlertDialogDelete({Key? key, this.onDelete, this.time})
      : super(key: key);

  Widget footer(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        InkWell(
          onTap: onDelete,
          child: Text('Delete'),
        ),
        InkWell(onTap: () => Navigator.pop(context), child: Text('Cancel')),
      ],
    );
  }

  Widget content() {
    return Text(
        '${timeGetTime(time!.startTime!)} - ${timeGetTime(time!.endTime!)}');
  }

  Widget title() {
    return Text('Delete');
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          title(),
          content(),
          footer(context),
        ],
      ),
    );
  }
}
