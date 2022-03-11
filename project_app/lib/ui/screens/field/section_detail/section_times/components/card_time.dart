import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_app/constants.dart';

class CardTime extends StatelessWidget {
  final String? startTime;
  final String? endTime;
  final String? date;
  final bool? isOwner;
  final bool? isReserve;
  final GestureTapCallback? onInfo;
  final GestureTapCallback? onDelete;
  final GestureTapCallback? onAccept;

  const CardTime({
    Key? key,
    this.startTime,
    this.endTime,
    this.date,
    this.isOwner,
    this.onInfo,
    this.onDelete,
    this.isReserve = false,
    this.onAccept,
  }) : super(key: key);

  Widget buttonReserve() {
    return isReserve!
        ? InkWell(
            onTap: onAccept,
            child: Icon(
              Icons.alarm_on_outlined,
              color: Colors.green,
            ),
          )
        : SizedBox();
  }

  Widget buttonRemove() {
    return isOwner!
        ? InkWell(
            onTap: onDelete,
            child: Icon(
              Icons.delete,
              color: Colors.redAccent,
            ),
          )
        : SizedBox();
  }

  Widget buttonInfo() {
    return isOwner!
        ? InkWell(
            onTap: onInfo,
            child: Icon(
              Icons.info_outline_rounded,
            ),
          )
        : SizedBox();
  }

  Widget formTime() => Row(
        children: [
          Icon(Icons.timer),
          SizedBox(width: 10),
          Text(
            "$startTime - $endTime",
            style: TextStyle(
              fontSize: 18,
            ),
          ),
        ],
      );

  Widget formDate() => Row(
        children: [
          Icon(Icons.calendar_today_rounded),
          SizedBox(width: 10),
          Text(
            '$date',
            style: TextStyle(
              color: Colors.black38,
            ),
          ),
        ],
      );

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: InkWell(
        onTap: onInfo,
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(width: 2, color: orangePrimaryColor),
            borderRadius: BorderRadius.circular(20),
          ),
          padding: EdgeInsets.all(8),
          child: Column(
            children: [
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    formDate(),
                    SizedBox(width: 16),
                    formTime(),
                    // SizedBox(width: 16),
                    // buttonInfo(),
                    SizedBox(width: 16),
                    buttonRemove(),
                    SizedBox(width: 16),
                    buttonReserve(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
