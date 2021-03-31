import 'package:flutter/material.dart';
import 'package:project_app/constants.dart';

import 'components/body.dart';

class CreateField extends StatelessWidget {
  final bool isOwner;
  final int clubId;

  const CreateField({
    Key key,
    @required this.isOwner,
    @required this.clubId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: creamPrimaryColor,
      appBar: AppBar(
        title: Text('Create Field'),
      ),
      body: Body(userId: clubId),
    );
  }
}

