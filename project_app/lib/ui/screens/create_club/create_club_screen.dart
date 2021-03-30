import 'package:flutter/material.dart';
import 'package:project_app/ui/screens/create_club/components/body.dart';

import '../../../constants.dart';

class CreateClub extends StatefulWidget {
  @override
  _CreateClubState createState() => _CreateClubState();
}

class _CreateClubState extends State<CreateClub> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: creamPrimaryColor,
      appBar: AppBar(
        title: Text(
          'Create club',
        ),
      ),
      body: Body(),
    );
  }
}
