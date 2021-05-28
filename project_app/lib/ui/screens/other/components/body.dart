import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:project_app/core/models/Club.dart';
import 'package:project_app/core/models/User.dart';
import 'package:project_app/core/services/AuthService.dart';
import 'package:project_app/core/services/ClubService.dart';
import 'package:project_app/core/services/UserService.dart';
import 'package:project_app/ui/screens/club/club_screen.dart';
import 'package:project_app/ui/screens/club/components/isCreate/create_club_screen.dart';
import 'package:project_app/ui/screens/club/components/notCreate/not_create_screen.dart';
import 'package:project_app/ui/screens/login/login_screen.dart';
import 'package:project_app/ui/screens/other/components/button_menu.dart';
import 'package:project_app/ui/screens/other/components/user_info.dart';
import 'package:project_app/ui/screens/profile/profile_screen.dart';
import 'package:http/http.dart' as http;

import 'dialog_logout.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  User user = User();
  bool _status = false;
  Uint8List _userImage;

  @override
  void initState() {
    fetchData();
    getUserImage();
    super.initState();
  }

  Future<void> getUserImage() async {
   var fileImage  = await UserService.imageDownload(await UserService.getUserId());
   _userImage = fileImage != null ? fileImage : null;
    // String url = '${UserService.pathUserImage(await UserService.getUserId())}';
    // var res = await http.get(url);
    // _userImage = res.bodyBytes.isNotEmpty ? res.bodyBytes : null;
    await Future.delayed(Duration(milliseconds: 200), () => setState(() {}));
  }

  Future<bool> fetchData() async {
    await getUserImage();
    int userId = await UserService.getUserId();
    user = await UserService.getById(userId: userId);
    await Future.delayed(Duration(milliseconds: 100), () => setState(() {}));
    return true;
  }

  Future<void> _onMyClub(BuildContext context) async {
    int userId = await UserService.getUserId();
    Club club = await ClubService.getByUserId(userId: userId);
    await Future.delayed(Duration(milliseconds: 200));
    bool _isCreate = club.id != null ? true : false;
    _isCreate
        ? Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ClubScreen(
                clubId: club.id,
                isOwner: true,
              ),
            ),
          )
        : Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => NotCreateScreen(),
            ),
          );
    // _isOwner
    //     ? Navigator.push(
    //         context,
    //         MaterialPageRoute(
    //           builder: (context) => ClubScreen(
    //             clubId: club.id,
    //             isOwner: _isOwner,
    //           ),
    //         ),
    //       )
    //     : Navigator.push(
    //         context,
    //         MaterialPageRoute(
    //           builder: (context) => NotCreateScreen(),
    //         ),
    //       );
  }

  Future<void> _onNeoMyClub(BuildContext context) async {
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
        // ? Navigator.push(
        //     context,
        //     MaterialPageRoute(
        //       builder: (context) => ClubScreen(
        //         clubId: club.id,
        //         isOwner: _isOwner,
        //       ),
        //     ),
        //   )
        : Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CreateClubScreen(),
              // builder: (context) => CreateClub(isOwner: _isOwner, club: club),
            ),
          );
    // : Navigator.push(
    //   context,
    //   MaterialPageRoute(
    //     builder: (context) => CreateClub(isOwner: _isOwner, club: club),
    //   ),
    // );
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        UserInfo(user: user, userImage: _userImage),
        buttonProfile(context),
        buttonMyClub(context),
        buttonLogout(context),
      ],
    );
  }
}
