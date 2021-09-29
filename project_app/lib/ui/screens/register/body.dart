import 'package:flutter/material.dart';
import 'package:project_app/constants.dart';

import 'components/form_register.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    Size sized = MediaQuery.of(context).size;
    return Container(
      height: sized.height,
      color: greyColor,
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: ListView(
        children: [
          Column(
            children: [
              SizedBox(height: sized.height * 0.1),
              Row(
                children: [
                  Text(
                    'Register',
                    style: TextStyle(
                        color: navyPrimaryColor,
                        fontSize: 40,
                        fontFamily: UiFont,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              SizedBox(height: 35),
              FormRegister(),
            ],
          ),
        ],
      ),
    );
  }
}
