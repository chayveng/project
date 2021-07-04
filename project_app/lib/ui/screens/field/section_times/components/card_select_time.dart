import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CardSelectTime extends StatelessWidget {
  final String? defaultStr;
  final DateTime? dateTime;
  final GestureTapCallback? onTap;

  const CardSelectTime({Key? key, this.dateTime, this.defaultStr, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          child: Column(
            children: [
              buildDate(),
              buildTime(),
            ],
          ),
        ),
      ),
    );
  }

  Container buildTime() {
    return Container(
      child: Container(
        width: 100,
        height: 35,
        child: Center(
          child: Text(
            dateTime != null ? getTime(dateTime!) : defaultStr!,
            style: TextStyle(fontSize: 18),
          ),
        ),
        // padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.orange.withOpacity(0.5),
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(10),
            bottomRight: Radius.circular(10),
          ),
        ),
      ),
    );
  }

  Container buildDate() {
    return Container(
      width: 100,
      decoration: decorateOfDate(),
      child: Center(
        child: dateTime != null
            ? Text(getDate(dateTime!))
            : Text(
          getDate(DateTime.now()),
          style: TextStyle(color: Colors.black38),
        ),
      ),
    );
  }

  BoxDecoration decorateOfDate() {
    return BoxDecoration(
      border: Border.all(
        width: 2,
        color: Colors.orange.withOpacity(0.5),
      ),
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(10),
        topRight: Radius.circular(10),
        bottomLeft: Radius.zero,
        bottomRight: Radius.zero,
      ),
    );
  }

  String getDate(DateTime dateTime) {
    return DateFormat('dd-MM-yyyy').format(dateTime);
  }

  String getTime(DateTime dateTime) {
    return DateFormat('HH:mm').format(dateTime);
  }
}
