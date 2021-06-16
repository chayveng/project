import 'package:flutter/material.dart';

import '../../../../../constants.dart';

class FormPickerTime extends StatelessWidget {
  final GestureTapCallback? onTap;
  final String? timeStr;
  const FormPickerTime({Key? key, this.onTap, this.timeStr}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          border: Border.all(width: 4, color: orangePrimaryColor),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Text(
            timeStr!,
            style: TextStyle(fontSize: 18),
          ),
        ),
      ),
    );
  }
}
