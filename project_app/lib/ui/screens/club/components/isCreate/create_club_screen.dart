import 'package:flutter/material.dart';
import 'package:project_app/constants.dart';

import 'body.dart';

class CreateClubScreen extends StatelessWidget {
  final bool isCreate;
  final int clubId;

  const CreateClubScreen({Key key, this.isCreate, this.clubId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: greyPrimaryColor,
      appBar: AppBar(
        backgroundColor: orangePrimaryColor.withOpacity(0.5),
        title: Text(isCreate ? 'Edit Club' : 'Create Club'),
      ),
      body: Body(isCreate: isCreate, clubId: clubId),
    );
  }
}
