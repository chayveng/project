import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:project_app/core/models/Club.dart';
import 'package:project_app/core/models/User.dart';
import 'package:project_app/core/services/AuthService.dart';
import 'package:project_app/core/services/ClubService.dart';
import 'package:project_app/core/services/UserService.dart';
import 'package:project_app/ui/screens/club/club_screen.dart';
import 'package:project_app/ui/screens/createClub/create_club.dart';
import 'package:project_app/ui/screens/login/login_screen.dart';
import 'package:project_app/ui/screens/other/components/button_menu.dart';
import 'package:project_app/ui/screens/other/components/user_info.dart';
import 'package:project_app/ui/screens/profile/profile_screen.dart';

import 'dialog_logout.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  User user = User();
  bool _status = false;

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

  Future<void> _onMyClub(BuildContext context) async {
    int userId = await UserService.getUserId();
    Club club = await ClubService.getByUserId(userId: userId);
    await Future.delayed(Duration(milliseconds: 500));
    bool _isOwner = club.id != null ? true : false;
    _isOwner
        ? Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ClubScreen(
                clubId: club.id,
                isOwner: _isOwner,
              ),
            ),
          )
        : Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CreateClub(isOwner: _isOwner, club: club),
            ),
          );
  }

  Future _onLogout(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) => DialogLogout(
        itOk: () {
          print('logout');
          AuthService.logout();
          Navigator.pushNamedAndRemoveUntil(
              context, LoginScreen.routeName, (route) => false);
        },
      ),
    );
  }

  Widget buttonLogout(BuildContext context) {
    return ButtonMenu(
      title: 'Logout',
      icon: Icons.logout,
      textColor: Colors.red,
      onPressed: () => _onLogout(context),
    );
  }

  Widget buttonMyClub(BuildContext context) {
    return ButtonMenu(
      title: 'My club',
      onPressed: () async => await _onMyClub(context),
    );
  }

  Widget buttonProfile(BuildContext context) {
    return ButtonMenu(
      title: 'Profile',
      onPressed: () async =>
          await Navigator.push(context,
              MaterialPageRoute(builder: (context) => ProfileScreen())) ??
          fetchData(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        UserInfo(user: user),
        buttonProfile(context),
        buttonMyClub(context),
        buttonLogout(context),
      ],
    );
  }
}
