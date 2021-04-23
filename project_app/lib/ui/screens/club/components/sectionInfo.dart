import 'package:flutter/material.dart';
import 'package:project_app/core/models/Club.dart';

import '../../../../constants.dart';

class SectionInfo extends StatelessWidget {
  final Club club;

  const SectionInfo({Key key, @required this.club}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      width: sized(context).width,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(10),
            bottomLeft: Radius.circular(10),
          ),
          color: creamPrimaryColor),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            // 'ClubName',
            club.title,
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: navyPrimaryColor),
          ),
          Text(
            club.detail ?? '-',
            style: TextStyle(fontSize: 18, color: navyPrimaryColor),
          ),
          Text(
            club.price ?? '-',
            style: TextStyle(fontSize: 18, color: navyPrimaryColor),
          ),
        ],
      ),
    );
  }
}
