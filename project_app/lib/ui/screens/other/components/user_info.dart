import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:project_app/core/models/User.dart';

import '../../../../constants.dart';

class UserInfo extends StatelessWidget {
  final User user;
  final Uint8List userImage;

  const UserInfo({Key key, this.user, this.userImage}) : super(key: key);

  Widget tel() {
    return Text(user.tel ?? '');
  }

  Widget formName(BuildContext context) {
    return Container(
      width: sized(context).width * 0.5,
      child: Text(
        '${user.firstName ?? ''}\,${user.lastName ?? ''}',
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
    );
    // return Row(
    //   children: [
    //     Text(user.firstName ?? ''),
    //     SizedBox(width: 8),
    //     Text(user.lastName ?? ''),
    //   ],
    // );
  }

  Widget username() {
    return Text(
      user.userName ?? '',
      style: TextStyle(
        fontSize: 16,
        color: navyPrimaryColor,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Expanded info(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          username(),
          SizedBox(height: 8),
          formName(context),
          SizedBox(height: 8),
          tel(),
        ],
      ),
    );
  }

  Widget boxUserImage() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Container(
        height: 100,
        width: 100,
        child: Container(
          color: creamPrimaryColor,
          child: userImage != null
              ? Image.memory(userImage, fit: BoxFit.cover,)
              : Icon(
                  Icons.person,
                  color: navyPrimaryColor.withOpacity(0.7),
                  size: 75,
                ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
      width: sized(context).width,
      child: Row(
        children: [
          boxUserImage(),
          SizedBox(width: 10),
          info(context),
        ],
      ),
    );
  }
}
