import 'package:flutter/material.dart';
import 'package:project_app/constants.dart';
import 'package:project_app/ui/screens/profile/components/profile_menu.dart';
import 'package:project_app/ui/screens/profile/components/top_profile.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: grayPrimaryColor,
      ),
      child: Container(
        child: Column(
          children: [
            TopProfile(),
            ProfileMenu(title: 'Profile', onPressed: (){}),
            ProfileMenu(title: 'Setting', onPressed: (){}),
          ],
        ),
      ),
    );
  }
}

