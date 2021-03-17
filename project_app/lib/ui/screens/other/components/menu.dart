import 'package:flutter/material.dart';

import '../../../../constants.dart';
import '../../../../constants.dart';


class Menu extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;

  const Menu({
    Key key,
    @required this.title,
    @required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size sized = MediaQuery.of(context).size;
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
                title,
                style: TextStyle(
                  fontSize: 16,
                  color: greenPrimaryColor
                ),
              ),
            ),
            Icon(
              Icons.keyboard_arrow_right_rounded,
            ),
          ],
        ),
        onPressed: onPressed,
      ),
    );
  }
}
