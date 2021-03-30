import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:project_app/core/models/Club.dart';

import '../../../constants.dart';
import 'components/body.dart';

class ClubScreen extends StatelessWidget {
  static String routeName = '/club';

  final Club club;
  final bool isOwner;

  const ClubScreen({
    Key key,
    @required this.club,
    this.isOwner = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Colors.white
    ));
    return Scaffold(
      backgroundColor: grayPrimaryColor,
      body: Body(club: club, isOwner: isOwner),
    );
  }
}
