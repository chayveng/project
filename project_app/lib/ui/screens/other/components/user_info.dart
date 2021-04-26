import 'package:flutter/material.dart';
import 'package:project_app/core/models/User.dart';

import '../../../../constants.dart';

class UserInfo extends StatelessWidget {
  final User user;

  const UserInfo({Key key, this.user}) : super(key: key);

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
    // return Container(
    //   width: sized(context).width * 0.6,
    //   child: Row(
    //     children: [
    //       Text(user.firstName ?? ''),
    //       SizedBox(width: 8),
    //       Text(
    //         user.lastName ?? '',
    //         maxLines: 1,
    //         overflow: TextOverflow.ellipsis,
    //       ),
    //       // SizedBox(
    //       //   width: sized(context).width * 0.3,
    //       // ),
    //     ],
    //   ),
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

  Widget userImage() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Container(
        height: 100,
        width: 100,
        child: Container(
          color: creamPrimaryColor,
          child: Center(
            child: Icon(
              Icons.person,
              size: 75,
              color: navyPrimaryColor.withOpacity(0.8),
            ),
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
          userImage(),
          SizedBox(width: 10),
          info(context),
        ],
      ),
    );
  }
}
