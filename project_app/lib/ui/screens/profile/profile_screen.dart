import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:project_app/constants.dart';

import 'body.dart';

class ProfileScreen extends StatelessWidget {
  static String? routeName = '/profile';
  final Uint8List? userImage;

  ProfileScreen({Key? key, this.userImage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: greyPrimaryColor,
      body: Body(status: false, userImage: userImage!),
    );
  }
}
