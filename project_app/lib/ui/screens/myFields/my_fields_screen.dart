import 'package:flutter/material.dart';
import 'package:project_app/constants.dart';

import 'body.dart';

class MyFieldsScreen extends StatelessWidget {
  const MyFieldsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: greyColor,
      body: Body(),
    );
  }
}
