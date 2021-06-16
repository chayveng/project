import 'package:flutter/material.dart';

import '../../../../../constants.dart';

class FormPickerDate extends StatelessWidget {

  final GestureTapCallback? onTap;
  final String? dateStr;
  const FormPickerDate({Key? key, this.onTap, this.dateStr, }) : super(key: key);

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
        child: Text(
          dateStr!,
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
