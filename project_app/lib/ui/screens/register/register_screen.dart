import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_app/constants.dart';

import 'components/body.dart';

class RegisterScreen extends StatelessWidget {
  static String routeName = '/register';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: grayPrimaryColor,
      body: Body(),
    );
  }
}


