import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:project_app/ui/screens/test/components/dialog_date_time_picker/components/custom_slash.dart';

class DialogDateTimePicker extends StatefulWidget {
  final DateTime? startTime;
  final DateTime? endTime;

  const DialogDateTimePicker({
    Key? key,
    this.startTime,
    this.endTime,
  }) : super(key: key);

  @override
  _DialogDateTimePickerState createState() => _DialogDateTimePickerState();
}

class _DialogDateTimePickerState extends State<DialogDateTimePicker> {
  DateTime now = DateTime.now();
  DateTime? startTime, endTime;
  String? alertText;
  // Map dateTime = {'start': DateTime.now(), 'end': DateTime.now()};

  @override
  void initState() {
    setDefaultDateTime();
    super.initState();
  }

  _onSelect() {
    if (startTime!.isBefore(endTime!)) {
      Map response = {'start': startTime, 'end': endTime};
      setState(() {
        alertText = null;
      });
      Navigator.pop(context, response);
    } else {
      setState(() {
        alertText = 'StartTime isAfter';
      });
    }
  }

  _onCancel() {
    Navigator.pop(context);
  }

  _onPrint() {
    print('onPrint');
  }

  setDateTime(DateTime start, DateTime end) {
    startTime = start;
    endTime = end;
  }

  setDefaultDateTime() async {
    if (widget.startTime != null && widget.endTime != null) {
      setDateTime(widget.startTime!, widget.endTime!);
    } else {
      DateTime defaultDateTime = DateTime(now.year, now.month, now.day, 0, 0);
      setDateTime(defaultDateTime, defaultDateTime);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Select Time'),
      content: Container(
        height: 150,
        child: Row(
          children: [
            Expanded(
              child: Column(
                children: [
                  Text(DateFormat('dd/MM/yyyy').format(startTime!).toString()),
                  SizedBox(height: 10),
                  Expanded(
                    child: CupertinoDatePicker(
                      initialDateTime: startTime,
                      use24hFormat: true,
                      mode: CupertinoDatePickerMode.time,
                      onDateTimeChanged: (dateTime) {
                        setState(() {
                          startTime = dateTime;
                        });
                      },
                    ),
                  ),
                 buildAlertText(),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 35),
              child: CustomSlash(),
            ),
            Expanded(
              child: Column(
                children: [
                  Text(DateFormat('dd/MM/yyyy').format(endTime!).toString()),
                  SizedBox(height: 10),
                  Expanded(
                    child: CupertinoDatePicker(
                      initialDateTime: endTime,

                      use24hFormat: true,
                      mode: CupertinoDatePickerMode.time,
                      onDateTimeChanged: (dateTime) {
                        setState(() {
                          endTime = dateTime;
                        });
                      },
                    ),
                  ),
                 buildAlertText(),
                ],
              ),
            ),
          ],
        ),
      ),
      actions: [
        // TextButton(onPressed: _onPrint, child: Text('print')),
        TextButton(onPressed: _onCancel, child: Text('cancel')),
        TextButton(onPressed: _onSelect, child: Text('select')),
      ],
    );
  }

  Widget buildAlertText() {
    return alertText != null ? Text(
      alertText!,
      style: TextStyle(color: Colors.redAccent, fontSize: 12),
    ) : SizedBox();
  }
}
