import 'package:flutter/material.dart';
import 'package:project_app/ui/screens/test/components/section_select_time/time_spinner.dart';

class DialogTimePicker extends StatefulWidget {
  const DialogTimePicker({Key? key}) : super(key: key);

  @override
  _DialogTimePickerState createState() => _DialogTimePickerState();
}

class _DialogTimePickerState extends State<DialogTimePicker> {
  var hour = List.generate(24, (index) => index);
  var min = List.generate(6, (index) => index * 10);
  int isHour = 0;
  int isMin = 0;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Time Picker'),
      content: AspectRatio(
        aspectRatio: 5 / 3,
        child: Row(
          children: [
            Expanded(child: TimeSpinner(lst: hour)),
            Expanded(child: TimeSpinner(lst: min)),
          ],
        ),
      ),
    );
  }
}
