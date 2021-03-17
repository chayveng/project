import 'package:flutter/material.dart';
import 'package:project_app/constants.dart';

class TopProfile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size sized = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.only(bottom: 5),
      decoration: BoxDecoration(
        color: orangePrimaryColor,
      ),
      width: sized.width,
      height: sized.height * 0.2,
    );
  }
}
