import 'package:flutter/material.dart';
import 'package:project_app/core/services/AuthService.dart';
import 'package:project_app/ui/screens/login/login_screen.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    Size sized = MediaQuery.of(context).size;
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          RaisedButton(
            child: Container(
              width: sized.width,
              child: Center(
                child: Text('logout'),
              ),
            ),
            onPressed: () {
              print('logout');
              AuthService.logout();
              Navigator.pushNamedAndRemoveUntil(
                  context, LoginScreen.routeName, (route) => false);
            },
          ),
        ],
      ),
    );
  }
}
