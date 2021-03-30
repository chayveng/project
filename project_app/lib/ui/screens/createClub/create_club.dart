import 'package:flutter/material.dart';
import 'package:project_app/constants.dart';
import 'package:project_app/core/models/Club.dart';
import 'package:project_app/ui/screens/createClub/components/from_create.dart';

import 'components/not_created.dart';

class CreateClub extends StatelessWidget {
  final bool isOwner;
  final Club club;

  const CreateClub({
    Key key,
    @required this.isOwner,
    @required this.club,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: creamPrimaryColor,
      appBar: AppBar(
          title: Text('Create or Update'),
      ),
      body: isOwner == false
          ? NotCreated()
          : FormCreate(),
    );
  }



}
