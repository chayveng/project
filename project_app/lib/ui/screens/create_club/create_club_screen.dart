import 'package:flutter/material.dart';
import 'package:project_app/ui/screens/create_club/components/body.dart';

import '../../../constants.dart';

class CreateClubScreen extends StatefulWidget {
  @override
  _CreateClubScreenState createState() => _CreateClubScreenState();
}

class _CreateClubScreenState extends State<CreateClubScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: grayPrimaryColor,
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: greenPrimaryColor, //change your color here
        ),
        title: Text(
          'Create club',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: greenPrimaryColor,
          ),
        ),
        backgroundColor: creamPrimaryColor,
      ),
      body: Body(),
    );
  }
}
