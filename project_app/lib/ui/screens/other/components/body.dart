import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:project_app/constants.dart';
import 'package:project_app/core/models/Club.dart';
import 'package:project_app/core/services/AuthService.dart';
import 'package:project_app/core/services/ClubService.dart';
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

  Future<void> _onMyClub(BuildContext context) async {
    int userId = await AuthService.getUserId();
    Club club = await ClubService.getByUserId(userId: userId);
    await Future.delayed(Duration(milliseconds: 500));
    bool _isOwner = club.id != null ? true : false;
    print(club);
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
}