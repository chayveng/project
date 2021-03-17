import 'package:flutter/material.dart';
import 'package:project_app/constants.dart';

import '../../../../constants.dart';

class TopOther extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size sized = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.only(bottom: 2),
      color: creamPrimaryColor,
      width: sized.width,
      height: 185,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'UserName :',
            style: TextStyle(fontSize: 30, color: greenPrimaryColor),
          ),
          SizedBox(height: 20),
          Text(
            'Tel : ',
            style: TextStyle(fontSize: 20, color: greenPrimaryColor),
          ),
        ],
      ),
    );
  }
}
