import 'package:flutter/material.dart';

import 'body.dart';

class CustomDialogDatetimePicker extends StatefulWidget {
  const CustomDialogDatetimePicker({Key? key}) : super(key: key);

  @override
  _CustomDialogDatetimePickerState createState() => _CustomDialogDatetimePickerState();
}

class _CustomDialogDatetimePickerState extends State<CustomDialogDatetimePicker> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Body(),
    );
  }
}
