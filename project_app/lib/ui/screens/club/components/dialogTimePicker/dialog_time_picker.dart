import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:project_app/core/apis/Network/TimeNetwork.dart';
import 'package:project_app/core/models/Time.dart';

import 'field_time.dart';

class DialogTimePicker extends StatefulWidget {
  final int fieldId;

  const DialogTimePicker({
    Key key,
    @required this.fieldId,
  }) : super(key: key);

  @override
  _DialogTimePickerState createState() => _DialogTimePickerState();
}

class _DialogTimePickerState extends State<DialogTimePicker> {
  var _formKey = GlobalKey<FormState>();

  Future _onOk({
    @required Map<String, dynamic> startTime,
    @required Map<String, dynamic> endTime,
    @required BuildContext context,
  }) async {
    print('ok');
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      print('start: $startTime');
      print('end: $endTime');
      Time _time = Time();
      _time.fieldId = widget.fieldId;
      _time.startTime = '${startTime['h']}:${startTime['m']}';
      _time.endTime = '${endTime['h']}:${endTime['m']}';
      print(_time);
      print(await TimeNetwork.add(time: _time));
      Navigator.pop(context);
    }
  }

  void _onCancel(BuildContext context) {
    print('cancel');
    Navigator.pop(context);
  }

  Widget footer({
    @required BuildContext context,
    Map<String, dynamic> startTime,
    Map<String, dynamic> endTime,
  }) =>
      Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          SizedBox(width: 10),
          InkWell(
            child: Text('Cancel'),
            onTap: () => _onCancel(context),
          ),
          SizedBox(width: 30),
          InkWell(
            child: Text('Ok'),
            onTap: () async => await _onOk(
              startTime: startTime,
              endTime: endTime,
              context: context,
            ),
          ),
          SizedBox(width: 10),
        ],
      );

  Widget customColon() => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Text(
          ':',
          style: TextStyle(
            fontSize: 50,
            fontWeight: FontWeight.bold,
          ),
        ),
      );

  Widget formTime({@required Map<String, dynamic> timeMap}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        FieldTime(
          onSaved: (input) {
            if (input.isEmpty) {
              return timeMap['h'] = '00';
            } else if (int.parse(input) < 10) {
              return timeMap['h'] = '0$input';
            } else {
              timeMap['h'] = input;
            }
          },
          validator: (input) {
            if (input.isEmpty) {
              timeMap['h'] = '00';
              return null;
            } else if (int.parse(input) > 23) {
              return '> 24';
            }
            return null;
          },
        ),
        customColon(),
        FieldTime(
          onSaved: (input) {
            if (input.isEmpty) {
              return timeMap['m'] = '00';
            } else if (int.parse(input) < 10) {
              return timeMap['m'] = '0$input';
            } else {
              timeMap['m'] = input;
            }
          },
          validator: (input) {
            if (input.isEmpty) {
              timeMap['m'] = '00';
              return null;
            } else if (int.parse(input) > 59) {
              return '> 59';
            }
            return null;
          },
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    Size sized = MediaQuery.of(context).size;
    Map<String, dynamic> startTime = {'h': '', 'm': ''};
    Map<String, dynamic> endTime = {'h': '', 'm': ''};

    return AlertDialog(
      titlePadding: EdgeInsets.all(0),
      contentPadding: EdgeInsets.all(0),
      actionsPadding: EdgeInsets.all(0),
      title: Text('Select time'),
      content: Container(
        width: sized.width,
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('start'),
                SizedBox(height: 10),
                formTime(timeMap: startTime),
                Text('end'),
                formTime(timeMap: endTime),
                SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
      actions: [
        footer(context: context, startTime: startTime, endTime: endTime),
      ],
    );
  }
}
