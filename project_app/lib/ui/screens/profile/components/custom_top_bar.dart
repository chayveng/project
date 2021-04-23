import 'package:flutter/material.dart';

import '../../../../constants.dart';

class CustomTopBar extends StatelessWidget {
  final bool status;
  final GestureTapCallback onEdit;

  const CustomTopBar({
    Key key,
    @required this.status,
    @required this.onEdit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: creamPrimaryColor,
      child: SafeArea(
        child: Container(
          width: sized(context).width,
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              arrowBack(context),
              title(),
              edit(),
            ],
          ),
        ),
      ),
    );
  }


  Widget edit() {
    return GestureDetector(
      onTap: onEdit,
      child: Icon(
        status ? Icons.edit : Icons.edit_off,
        color: navyPrimaryColor,
        size: 22,
      ),
    );
  }

  Widget title() {
    return Text(
      'Profile',
      style: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: navyPrimaryColor,
      ),
    );
  }
  Widget arrowBack(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pop(context),
      child: Icon(
        Icons.arrow_back_ios_rounded,
        color: navyPrimaryColor,
        size: 22,
      ),
    );
  }
}
