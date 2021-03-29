import 'package:flutter/material.dart';

import 'components/body.dart';

class CreateClubScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create'),
      ),
      body: Body(),
    );
  }
}
