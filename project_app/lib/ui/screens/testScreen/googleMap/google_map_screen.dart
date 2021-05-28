import 'package:flutter/material.dart';
import 'package:project_app/constants.dart';

import 'components/body.dart';


class GoogleMapScreen extends StatelessWidget {
  const GoogleMapScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: greyPrimaryColor,
      body: Body(),
    );
  }
}
