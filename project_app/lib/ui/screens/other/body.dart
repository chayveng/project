import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:project_app/core/models/User.dart';
import 'package:project_app/core/services/AuthService.dart';
import 'package:project_app/core/services/UserService.dart';
import 'package:project_app/ui/components/custom_widget_loading.dart';

import 'package:project_app/ui/screens/login/login_screen.dart';
import 'package:project_app/ui/screens/myFields/my_fields_screen.dart';
import 'package:project_app/ui/screens/other/components/button_menu.dart';
import 'package:project_app/ui/screens/other/components/user_info.dart';
import 'package:project_app/ui/screens/profile/profile_screen.dart';

import 'components/dialog_logout.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  User? user = User();
  bool? _status = false;
  Uint8List? _userImage;

  Future<bool> fetchData() async {
    await getUserImage();
    int userId = await UserService.getUserId();
    user = await UserService.getById(userId: userId);
    await Future.delayed(Duration(milliseconds: 300));
    return true;
  }

  Future<void> getUserImage() async {
    var fileImage =
        await UserService.imageDownload(await UserService.getUserId());
    _userImage = fileImage != null ? fileImage : null;
  }

  Future<void> _onMyClub(BuildContext context) async {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => MyFieldsScreen()));
  }

  Future _onLogout(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) => DialogLogout(
        itOk: () async {
          print('logout');
          UserService.logout();
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => LoginScreen()),
            (route) => false,
          );
        },
      ),
    );
  }

  Widget buttonLogout(BuildContext context) {
    return ButtonMenu(
      title: 'ออกจากระบบ',
      icon: Icons.logout,
      textColor: Colors.red,
      onPressed: () => _onLogout(context),
    );
  }

  Widget buttonMyClub(BuildContext context) {
    return ButtonMenu(
      title: 'สนามของฉัน',
      onPressed: () async => await _onMyClub(context),
    );
  }

  Widget buttonProfile(BuildContext context) {
    return ButtonMenu(
      title: 'ข้อมูลส่วนตัว',
      onPressed: () async =>
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ProfileScreen(
                userImage: _userImage,
              ),
            ),
          ) ??
          fetchData(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: fetchData(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasError) print(snapshot.hasError);
        if (snapshot.hasData) print(snapshot.data);
        return snapshot.hasData
            ? SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // SizedBox(height: 30),
                    SizedBox(height: 20),
                    UserInfo(user: user, userImage: _userImage),
                    SizedBox(height: 10),
                    buttonProfile(context),
                    buttonMyClub(context),
                    buttonLogout(context),
                  ],
                ),
              )
            : CustomWidgetLoading();
      },
    );
  }
}
