import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:project_app/constants.dart';
import 'package:project_app/core/models/Club.dart';
import 'package:project_app/core/models/User.dart';
import 'package:project_app/core/services/AuthService.dart';
import 'package:project_app/core/services/ClubService.dart';
import 'package:project_app/core/services/UserService.dart';
import 'package:project_app/ui/screens/club/club_screen.dart';
import 'package:project_app/ui/screens/createClub/create_club.dart';
import 'package:project_app/ui/screens/login/login_screen.dart';
import 'package:project_app/ui/screens/other/components/button_menu.dart';

import 'custom_dialog.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  User user = User();

  @override
  void initState() {
    fetchData();
    super.initState();
  }

  Future<bool> fetchData() async {
    int userId = await AuthService.getUserId();
    user = await UserService.getById(userId: 1);
    await Future.delayed(Duration(milliseconds: 100), () => setState(() {}));
    return true;
  }

  Future<void> _onMyClub(BuildContext context) async {
    int userId = await AuthService.getUserId();
    Club club = await ClubService.getByUserId(userId: userId);
    await Future.delayed(Duration(milliseconds: 500));
    bool _isOwner = club.id != null ? true : false;
    _isOwner == true
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
      builder: (context) => CustomDialog(
        itOk: () {
          print('logout');
          AuthService.logout();
          Navigator.pushNamedAndRemoveUntil(
              context, LoginScreen.routeName, (route) => false);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          userInfo(),
          ButtonMenu(
            title: 'Profile',
            onPressed: () => print('onProfile'),
          ),
          ButtonMenu(
            title: 'My club',
            onPressed: () async => await _onMyClub(context),
          ),
          ButtonMenu(
            title: 'Logout',
            icon: Icons.logout,
            textColor: Colors.red,
            onPressed: () => _onLogout(context),
          ),
        ],
      ),
    );
  }

  Column userInfo() {
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
            fontSize: 16,
          ),
        ),
      ],
    );
  }
}
