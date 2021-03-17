import 'package:flutter/material.dart';

import '../../../../constants.dart';

class ProfileMenu extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;

  const ProfileMenu({
    Key key,
    @required this.title,
    @required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size sized = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.only(top: 2),
      width: sized.width,
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
