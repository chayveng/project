import 'package:flutter/material.dart';
import 'package:project_app/constants.dart';
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
    return InkWell(
      onTap: () {
        Navigator.pop(context);
      },
      child: Container(
        width: sized(context).width,
        height: 45,
        decoration: BoxDecoration(
          color: orangeColor.withOpacity(0.1),
          border: Border(
            top: BorderSide(width: 1, color: orangeColor),
          ),
        ),
        child: Center(
          child: Text(
            'ปิด',
            style: TextStyle(fontSize: 16),
          ),
        ),
      ),
    );
  }

  Widget content() {
    return Container(
      padding: EdgeInsets.all(12),
      width: sized(context).width,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text('เวลา : ',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              Text(
                '${timeGetTime(widget.time!.startTime!)}+ - +${timeGetTime(widget.time!.endTime!)}',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text('ชื่อผู้จอง : ',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              Text(
                '${user.userName}',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text('โทร :',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              Text(
                '${user.tel}',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget title() {
    return Text(
      'ข้อมูลการจอง',
      style: TextStyle(
        fontSize: 20,
        color: orangeColor,
      ),
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
