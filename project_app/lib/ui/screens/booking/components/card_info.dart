import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:project_app/core/models/Field.dart';
import 'package:project_app/core/models/Time.dart';

import '../../../../constants.dart';

class CardInfo extends StatefulWidget {
  final VoidCallback? onMap;
  final Field? field;
  final Time? time;

  const CardInfo({
    Key? key,
    @required this.onMap,
    this.field,
    this.time,
  }) : super(key: key);

  @override
  _CardInfoState createState() => _CardInfoState();
}

class _CardInfoState extends State<CardInfo> {
  Widget buildTitle() {
    return Text(
      widget.field!.title!,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 20,
        color: orangeColor,
      ),
    );
  }

  Widget buildMap() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Icon(
          Icons.location_pin,
          color: orangeColor,
        ),
        TextButton(
          onPressed: widget.onMap,
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

  Widget buildTime() {
    return Row(
      children: [
        Icon(
          Icons.access_alarm,
          color: Colors.redAccent,
        ),
        SizedBox(width: 5),
        Text(
          '${timeGetTime(widget.time!.startTime!)} - ${timeGetTime(widget.time!.endTime!)}',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
      ],
    );
  }

  Widget buildDate() {
    return Row(
      children: [
        Icon(
          Icons.event_busy,
          color: Colors.pink,
        ),
        SizedBox(width: 5),
        Text(
          timeGetDate(widget.time!.startTime!),
          style: TextStyle(
            fontSize: 18,
          ),
        ),
      ],
    );
  }

  Widget formInfo() {
    return Column(
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
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: sized(context).width,
      margin: EdgeInsets.all(8),
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        border: Border.all(width: 3, color: orangePrimaryColor),
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
      child: formInfo(),
    );
  }

// Future<void> _launchInBrowser() async {
//   String location = widget.field!.location!;
//   int comma = location.indexOf(',');
//   double lat = double.parse(location.substring(0,comma));
//   double lng = double.parse(location.substring(comma + 1, location.length - 1));
//   String url = 'https://www.google.com/maps/@${lat},${lng},16z';
//   if (await canLaunch(url)) {
//     print('go');
//     await launch(
//         url,
//         forceSafariVC: false,
//         forceWebView: false,
//         headers: <String, String>{'header_key': 'header_value'});
//   } else {
//     print('nnn');
//     throw 'Could not launch $url';
//   }
// }

// Future<void> _launchInApp() async {
//   String location = widget.field!.location!;
//   int comma = location.indexOf(',');
//   double lat = double.parse(location.substring(0,comma));
//   double lng = double.parse(location.substring(comma + 1, location.length - 1));
//   String url = 'https://www.google.com/maps/@${lat},${lng},16z';
//   if (await canLaunch(url)) {
//     await launch(url,
//         forceSafariVC: true,
//         forceWebView: false,
//         headers: <String, String>{'header_key': 'header_value'});
//   } else {
//     throw 'Could not launch $url';
//   }
// }
}
