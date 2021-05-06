import 'package:flutter/material.dart';

import 'body.dart';

class CreateClubScreen extends StatelessWidget {
  final isCreate;

  const CreateClubScreen({Key key, this.isCreate}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(isCreate);
    return Scaffold(
      body: Body(isCreate: isCreate),
    );
  }
}
