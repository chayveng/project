import 'package:flutter/material.dart';
import 'package:project_app/core/models/User.dart';
import 'package:project_app/core/services/UserService.dart';

import '../../../../constants.dart';

class UserInfo extends StatefulWidget {
  @override
  _UserInfoState createState() => _UserInfoState();
}

class _UserInfoState extends State<UserInfo> {
  User user = User();

  @override
  void initState() {
    fetchData();
    super.initState();
  }

  Future<bool> fetchData() async {
    int userId = await UserService.getUserId();
    user = await UserService.getById(userId: userId);
    await Future.delayed(Duration(milliseconds: 100), () => setState(() {}));
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.all(10),
          width: 150,
          height: 150,
          decoration: BoxDecoration(
            color: creamPrimaryColor,
            borderRadius: BorderRadius.all(
              Radius.circular(20),
            ),
          ),
          child: Icon(
            Icons.person,
            color: Colors.black.withOpacity(0.5),
            size: 150,
          ),
        ),
        Text(
          user.userName ?? '',
          style: TextStyle(
            fontSize: 24,
            color: blackPrimaryColor.withOpacity(0.7),
          ),
        ),
        SizedBox(height: 8),
        Text(
          user.tel ?? '0884848434',
          style: TextStyle(
            fontSize: 20,
            color: blackPrimaryColor.withOpacity(0.7),
          ),
        ),
      ],
    );
  }
}
