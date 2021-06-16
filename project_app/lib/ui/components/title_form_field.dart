import 'package:flutter/material.dart';

class TitleFormField extends StatelessWidget {
  final IconData? iconData;
  final String? title;

  const TitleFormField(
      {Key? key, @required this.iconData, @required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(width: 8),
          Icon(
            iconData!,
            size: 26,
          ),
          SizedBox(width: 8),
          Text(
            title!,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
