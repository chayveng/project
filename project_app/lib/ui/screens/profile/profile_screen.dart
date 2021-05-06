import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:project_app/constants.dart';

import 'components/body.dart';

class ProfileScreen extends StatelessWidget {
  static String routeName = '/profile';
  final Uint8List userImage;

  ProfileScreen({Key key,@required this.userImage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: grayPrimaryColor,
      body: Body(status: false, userImage: userImage),
    );
  }
}
