import 'package:flutter/material.dart';

import '../../../../../../constants.dart';

class ButtonBooking extends StatelessWidget {
  final GestureTapCallback? onTap;

  const ButtonBooking({Key? key,@required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Material(
        color: orangePrimaryColor.withOpacity(0.5),
        child: InkWell(
          onTap: onTap,
          child: Container(
            width: sized(context).width,
            height: 45,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              border: Border.all(width: 2, color: orangePrimaryColor),
            ),
            child: Center(
              child: Text(
                'จอง',
                style: TextStyle(fontSize: 20),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
