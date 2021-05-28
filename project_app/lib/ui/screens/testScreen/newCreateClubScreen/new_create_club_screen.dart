import 'package:flutter/material.dart';

import '../../../../constants.dart';
import 'body.dart';

class NewCreateClubScreen extends StatelessWidget {
  final bool isCreate;
  final int clubId;

  const NewCreateClubScreen({Key key, this.isCreate, this.clubId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: greyPrimaryColor,
      appBar: AppBar(
        title: Text('Create Club Screen'),
      ),
      body: Body(clubId: clubId, isCreate: isCreate),
    );
  }
}
