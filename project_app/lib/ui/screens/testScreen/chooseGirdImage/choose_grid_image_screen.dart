import 'package:flutter/material.dart';

import '../../../../constants.dart';
import 'body.dart';

class ChooseGridImageScreen extends StatelessWidget {
  const ChooseGridImageScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: greyPrimaryColor,
      appBar: AppBar(title: Text('ChooseImage')),
      body: Body(),
    );
  }
}
