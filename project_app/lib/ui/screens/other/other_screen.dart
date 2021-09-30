import 'package:flutter/material.dart';
import 'package:project_app/constants.dart';

import 'body.dart';

class OtherScreen extends StatelessWidget {
  static String routeName = '/other';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: greyColor,
      appBar: AppBar(
        title: Text(
          'อื่น ๆ',
        ),
      ),
      body: Body(),
    );
  }
}
