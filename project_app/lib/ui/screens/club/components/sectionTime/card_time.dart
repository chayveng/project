import 'package:flutter/material.dart';
import 'package:project_app/core/models/Time.dart';

class CardTime extends StatelessWidget {
  static double isSized = 55;
  final bool isOwner;
  final Time time;
  final VoidCallback onRemoveTime;
  final VoidCallback onCardTime;
  final GestureTapCallback onTap;

  CardTime({
    Key key,
    @required this.isOwner,
    @required this.time,
    this.onRemoveTime,
    this.onCardTime,
    this.onTap,
  }) : super(key: key);

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

  Widget activeIcon() => Icon(
        time.status ? Icons.album : Icons.album_outlined,
        color: time.status ? Colors.redAccent : Colors.lightGreenAccent,
      );

  Widget cardTime() => Container(
        height: 50,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            activeIcon(),
            textTime(),
            buttonRemove(),
          ],
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Material(
      child: InkWell(
        onTap: onTap,
        child: cardTime(),
      ),
    );
  }
}
