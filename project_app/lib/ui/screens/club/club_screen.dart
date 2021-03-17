import 'package:flutter/material.dart';
import 'package:project_app/core/models/Club.dart';

import '../../../constants.dart';
import 'components/body.dart';

class ClubScreen extends StatelessWidget {
  static String routeName = '/club';

  final Club club;

  const ClubScreen({
    Key key,
    this.club,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: grayPrimaryColor,
      appBar: AppBar(
        backgroundColor: creamPrimaryColor,
        iconTheme: IconThemeData(
          color: navyPrimaryColor,
        ),
        title: Text(
          '${club.title}',
          style: TextStyle(
            color: navyPrimaryColor,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Body(club: club),
    );
  }
}
