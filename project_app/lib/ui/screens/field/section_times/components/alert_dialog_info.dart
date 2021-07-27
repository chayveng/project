import 'package:flutter/material.dart';
import 'package:project_app/core/models/Field.dart';
import 'package:project_app/core/models/Time.dart';
import 'package:project_app/core/models/User.dart';
import 'package:project_app/core/services/FieldServices.dart';
import 'package:project_app/core/services/UserService.dart';

class AlertDialogInfo extends StatefulWidget {
  final Time? time;

  const AlertDialogInfo({Key? key, this.time}) : super(key: key);

  @override
  _AlertDialogInfoState createState() => _AlertDialogInfoState();
}

class _AlertDialogInfoState extends State<AlertDialogInfo> {
  User user = User();
  Field field = Field();

  @override
  initState() {
    fetchData();
    super.initState();
  }

  Future<void> fetchData() async {
    user = await UserService.getById(userId: widget.time!.userId);
    field = await FieldServices.findById(fieldId: widget.time!.fieldId);
    await Future.delayed(Duration(milliseconds: 300));
    setState(() {});
  }

  Widget footer(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        InkWell(
          onTap: () => Navigator.pop(context),
          child: Text('Close'),
        ),
      ],
    );
  }

  Widget content() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
            '${timeGetTime(widget.time!.startTime!)} - ${timeGetTime(widget.time!.endTime!)}'),
        Text('book by: ${user.userName}'),
        Text('tel: ${user.tel}'),
      ],
    );
  }

  Widget title() {
    return Text('Time Info');
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
