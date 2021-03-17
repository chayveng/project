import 'package:flutter/material.dart';
import 'package:project_app/ui/screens/other/components/menu.dart';
import 'package:project_app/ui/screens/other/components/top_other.dart';
import '../../../../constants.dart';
import '../../../../core/services/AuthService.dart';
import '../../../components/rounded_button.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    Size sized = MediaQuery.of(context).size;
    return Container(
      child: ListView(
        children: [
          Column(
            children: [
              TopOther(),
              Menu(title: 'Profile', onPressed: () {}),
              Menu(title: 'Setting', onPressed: () {}),
              Menu(title: 'Club', onPressed: () {}),
              MenuLogout(sized: sized),
            ],
          ),
        ],
      ),
    );
  }
}

class MenuLogout extends StatelessWidget {
  const MenuLogout({
    Key key,
    @required this.sized,
  }) : super(key: key);

  final Size sized;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 2),
      width: sized.width,
      height: 65,
      child: FlatButton(
        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        color: creamPrimaryColor,
        child: Row(
          children: [
            SizedBox(width: 20),
            Expanded(
              child: Text(
                'Logout',
                style: TextStyle(fontSize: 16, color: Colors.red),
              ),
            ),
            Icon(
              Icons.logout,
            ),
          ],
        ),
        onPressed: () {
          AuthService.logout();
          Navigator.pushReplacementNamed(context, '/login');
        },
      ),
    );
  }
}
