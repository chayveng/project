import 'package:flutter/material.dart';
import 'package:project_app/ui/screens/field/section_times/select_date_time.dart';


class CustomDialogDatetimePicker extends StatefulWidget {
  const CustomDialogDatetimePicker({Key? key}) : super(key: key);

  @override
  _CustomDialogDatetimePickerState createState() => _CustomDialogDatetimePickerState();
}

class _CustomDialogDatetimePickerState extends State<CustomDialogDatetimePicker> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: SelectDateTime(),
    );
  }
}
