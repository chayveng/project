import 'package:flutter/material.dart';
import 'package:project_app/constants.dart';
import 'package:project_app/core/models/Time.dart';

class CardTime extends StatelessWidget {
  static double isSized = 55;
  final bool isOwner;
  final Time time;
  final VoidCallback onRemoveTime;
  final VoidCallback onCardTime;
  final GestureTapCallback onBooking;
  final VoidCallback onActiveIcon;

  final VoidCallback onInfo;

  CardTime({
    Key key,
    @required this.isOwner,
    @required this.time,
    this.onRemoveTime,
    this.onCardTime,
    this.onBooking,
    this.onActiveIcon,
    this.onInfo,
  }) : super(key: key);

  Widget buttonInfo() {
    return isOwner
        ? IconButton(
            icon: Icon(Icons.info_outline_rounded),
            onPressed: onInfo,
          )
        : SizedBox();
  }

  Widget buttonRemove() => isOwner
      ? IconButton(
          icon: Icon(Icons.remove),
          onPressed: onRemoveTime,
        )
      : SizedBox();

  Widget textTime() => Expanded(
        child: Text(
          '${time.startTime} - ${time.endTime}',
          style: TextStyle(
            fontSize: 18,
          ),
        ),
      );

  Widget activeIcon() {
    return isOwner
        ? IconButton(
            icon: Icon(
              time.status ? Icons.album : Icons.album_outlined,
              color: time.status ? Colors.redAccent : Colors.lightGreenAccent,
            ),
            onPressed: onActiveIcon,
          )
        : Icon(
            time.status ? Icons.album : Icons.album_outlined,
            color: time.status ? Colors.redAccent : Colors.lightGreenAccent,
          );
  }

  Widget cardTime() => Container(
        height: 50,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(color: creamPrimaryColor),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              activeIcon(),
              SizedBox(width: 10),
              textTime(),
              buttonInfo(),
              buttonRemove(),
            ],
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Material(
      child: InkWell(
        onTap: onBooking,
        child: cardTime(),
      ),
    );
  }
}
