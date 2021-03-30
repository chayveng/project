import 'package:flutter/material.dart';

import '../../../../constants.dart';

class ButtonMenu extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;
  final IconData icon;
  final Color textColor;
  final Color iconColor;

  const ButtonMenu({
    Key key,
    @required this.title,
    @required this.onPressed,
    this.icon = Icons.keyboard_arrow_right_rounded,
    this.textColor = navyPrimaryColor,
    this.iconColor = navyPrimaryColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: sized(context).width,
      margin: EdgeInsets.only(top: 5),
      child: FlatButton(
        color: creamPrimaryColor,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: Text(
                  title,
                  style: TextStyle(
                    color: textColor,
                  ),
                ),
              ),
            ),
            Icon(
              icon,
              color: iconColor,
            ),
          ],
        ),
        onPressed: onPressed,
      ),
    );
  }
}
