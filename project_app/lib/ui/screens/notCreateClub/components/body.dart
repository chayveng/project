import 'package:flutter/material.dart';
import 'package:project_app/core/models/Club.dart';
import 'package:project_app/ui/components/rounded_button.dart';
import 'package:project_app/ui/screens/createClub/create_club.dart';

import '../../../../constants.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {

  void _onCreate(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CreateClub(
          isOwner: true,
          club: Club(),
        ),
      ),
    );
  }

  Container buildButtonCreate(BuildContext context) {
    return Container(
      width: sized(context).width * 0.5,
      child: RoundedButton(
        text: 'Create',
        onTap: () => _onCreate(context),
      ),
    );
  }

  Text buildText() {
    return Text(
      'Don\'t have your club',
      style: TextStyle(fontSize: 16),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: sized(context).width,
      height: sized(context).height,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          buildText(),
          SizedBox(height: 10),
          buildButtonCreate(context),
        ],
      ),
    );
  }
}
