import 'package:flutter/material.dart';
import 'package:project_app/constants.dart';

import 'components/form_login.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    Size sized = MediaQuery
        .of(context)
        .size;
    return Container(
      color: greyPrimaryColor,
      height: sized.height,
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: ListView(
        children: [
          Column(
            children: [
              SizedBox(height: sized.height * 0.1),
              Row(
                children: [
                  Text(
                    'Login',
                    style: TextStyle(
                      fontSize: 40,
                      color: navyPrimaryColor,
                      fontFamily: UiFont,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 35),
              FormLogin(),
            ],
          ),
        ],
      ),
    );
  }
}
