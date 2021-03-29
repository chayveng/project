import 'package:flutter/material.dart';
import 'package:project_app/constants.dart';
import 'package:project_app/core/services/AuthService.dart';
import 'package:project_app/ui/screens/create_club/CreateClubScreen.dart';
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
          BuildButton(
            text: "My Club",
            onPressed: () {
              // print('Create Club');
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => CreateClubScreen()));
            },
          ),
          BuildButton(
            text: "Logout",
            onPressed: () => showDialog(
              context: context,
              builder: (context) => CustomDialog(
                itOk: () => _isLogout(context),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _isLogout(BuildContext context) {
    print('logout');
    AuthService.logout();
    Navigator.pushNamedAndRemoveUntil(
        context, LoginScreen.routeName, (route) => false);
  }
}

class CustomDialog extends StatelessWidget {
  final VoidCallback itOk;

  const CustomDialog({
    Key key,
    this.itOk,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Logout'),
      actions: [
        FlatButton(
          onPressed: () => Navigator.pop(context),
          child: Text("Cancel"),
        ),
        FlatButton(
          onPressed: itOk,
          child: Text("Ok"),
        ),
      ],
    );
  }
}

class BuildButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const BuildButton({
    Key key,
    @required this.text,
    @required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      child: Container(
        width: sized(context).width,
        child: Center(
          child: Text(text),
        ),
      ),
      onPressed: onPressed,
    );
  }
}
