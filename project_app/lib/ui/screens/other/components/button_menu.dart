import 'package:flutter/material.dart';

import '../../../../constants.dart';

class ButtonMenu extends StatelessWidget {
  final String? title;
  final VoidCallback? onPressed;
  final IconData? icon;
  final Color? textColor;
  final Color? iconColor;

  const ButtonMenu({
    Key? key,
    @required this.title,
    @required this.onPressed,
    this.icon = Icons.keyboard_arrow_right_rounded,
    this.textColor = navyPrimaryColor,
    this.iconColor = navyPrimaryColor,
  }) : super(key: key);

  Widget detail() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Expanded(
          child: Text(
            title!,
            style: TextStyle(color: textColor),
          ),
        ),
        Icon(
          icon,
          color: iconColor,
        )
      ],
    );
  }

  Padding cardMenu() {
    return Padding(
      padding: const EdgeInsets.only(top: 8, left: 8, right: 8),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Material(
          color: Colors.white,
          child: InkWell(
            onTap: onPressed,
            child: Container(
              height: 50,
              padding: EdgeInsets.only(left: 20, right: 10),
              child: detail(),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return cardMenu();
  }
}
