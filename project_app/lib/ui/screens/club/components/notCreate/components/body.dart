import 'package:flutter/material.dart';
import 'package:project_app/ui/components/rounded_button.dart';
import 'package:project_app/ui/screens/club/components/isCreate/create_club_screen.dart';

import '../../../../../../constants.dart';

class Body extends StatefulWidget {
  const Body({Key key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {

  void _onCreate(BuildContext context) {
    print('create');
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CreateClubScreen(isCreate: false),
      ),
    );
  }

  Widget buildButtonCreate(BuildContext context) {
    return Container(
      width: sized(context).width * 0.6,
      child: RoundedButton(
        text: 'Create',
        onTap: () => _onCreate(context),
      ),
    );
  }

  Widget buildText() {
    return Text(
      'Don\'t have your club',
      style: TextStyle(
        fontSize: 16,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          buildText(),
          SizedBox(height: 20),
          buildButtonCreate(context),
        ],
      ),
    );
  }
}
