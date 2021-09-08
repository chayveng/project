import 'package:flutter/material.dart';
import 'package:project_app/constants.dart';

class TitleBar extends StatelessWidget {
  final String? title;
  final IconData? icon;

  const TitleBar({
    Key? key,
    @required this.title,
    @required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Icon(icon!, color: navyPrimaryColor),
          SizedBox(width: 8),
          Text(
            title!,
            style: TextStyle(
              color: navyPrimaryColor,
              fontWeight: FontWeight.bold,
              fontSize: 16
            ),
          ),
        ],
      ),
    );
  }
}
