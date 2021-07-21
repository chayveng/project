import 'package:flutter/material.dart';

import '../../../../constants.dart';

class CardTime extends StatelessWidget {
  final VoidCallback? onTapMap;

  const CardTime({
    Key? key,
    @required this.onTapMap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: sized(context).width,
      margin: EdgeInsets.all(8),
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: whiteColor,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 7,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          buildTitle(),
          SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              buildDate(),
              buildTime(),
            ],
          ),
          buildMap(),
        ],
      ),
    );
  }

  Text buildTitle() {
    return Text(
      'ชื่อสนาม',
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 20,
        color: orangeColor,
      ),
    );
  }

  Row buildMap() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Icon(
          Icons.location_pin,
          color: orangeColor,
        ),
        TextButton(
          onPressed: onTapMap,
          child: Text(
            'แผนที่',
            style: TextStyle(
              color: navyPrimaryColor,
              fontSize: 16,
              decoration: TextDecoration.underline,
            ),
          ),
        ),
      ],
    );
  }

  Row buildTime() {
    return Row(
      children: [
        Icon(
          Icons.access_alarm,
          color: Colors.redAccent,
        ),
        SizedBox(width: 5),
        Text(
          '12:00 - 13:00',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
      ],
    );
  }

  Row buildDate() {
    return Row(
      children: [
        Icon(
          Icons.event_busy,
          color: Colors.pink,
        ),
        SizedBox(width: 5),
        Text(
          '01-11-2021',
          style: TextStyle(
            fontSize: 18,
          ),
        ),
      ],
    );
  }
}
