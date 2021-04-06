import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:project_app/core/apis/TimeApi.dart';
import 'package:project_app/core/models/Time.dart';

class CustomTimePicker extends StatefulWidget {
  @override
  _CustomTimePickerState createState() => _CustomTimePickerState();
}

class _CustomTimePickerState extends State<CustomTimePicker> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: RaisedButton(
        child: Text('Time Picker'),
        onPressed: () {
          showDialog(
              context: context,
              builder: (BuildContext context) => CustomDialog());
        },
      ),
    );
  }
}

class CustomDialog extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Size sized = MediaQuery.of(context).size;
    Map<String, dynamic> startTime = {'h': '', 'm': ''};
    Map<String, dynamic> endTime = {'h': '', 'm': ''};
    Time time = Time();
    return AlertDialog(
      titlePadding: EdgeInsets.all(0),
      contentPadding: EdgeInsets.all(0),
      actionsPadding: EdgeInsets.all(0),
      title: Text('Select time'),
      content: Container(
        // height: 300,
        // height: sized.height * 0.3,
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
                buildTimePicker(startTime),
                Text('end'),
                buildTimePicker(endTime),
                SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            SizedBox(width: 10),
            InkWell(
              onTap: () {
                print('cancel');
                Navigator.pop(context);
              },
              child: Text('Cancel'),
            ),
            SizedBox(width: 30),
            InkWell(
              onTap: () async {
                print('ok');
                if (_formKey.currentState.validate()) {
                  _formKey.currentState.save();
                  print('start: $startTime');
                  print('end: $endTime');
                  Time _time = Time();
                  _time.fieldId = 2;
                  _time.startTime = '${startTime['h']}:${startTime['m']}:00';
                  _time.endTime = '${endTime['h']}:${endTime['m']}:00';
                  print(_time);
                  print(await TimeNetwork.add(time: _time));
                }
              },
              child: Text('Ok'),
            ),
            SizedBox(width: 10),
          ],
        ),
      ],
    );
  }

  Row buildTimePicker(Map<String, dynamic> timeMap) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        FieldTimePicker(
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
        FieldTimePicker(
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
}

class FieldTimePicker extends StatelessWidget {
  final FormFieldSetter onSaved;
  final FormFieldValidator validator;

  const FieldTimePicker({
    Key key,
    this.onSaved,
    this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double size = 80;
    return Container(
      width: size,
      height: size,
      child: Center(
        child: TextFormField(
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 40),
          maxLength: 2,
          keyboardType: TextInputType.phone,
          autofocus: true,
          onSaved: onSaved,
          validator: validator,
          decoration: InputDecoration(
            hintText: '00',
            filled: true,
            fillColor: Colors.yellow,
            counterText: '',
            enabledBorder: buildUnderlineInputBorder(),
            focusedBorder: buildUnderlineInputBorder(),
            errorBorder: buildUnderlineInputBorder(),
            focusedErrorBorder: buildUnderlineInputBorder(),
          ),
        ),
      ),
    );
  }

  UnderlineInputBorder buildUnderlineInputBorder() {
    return UnderlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(10)),
      borderSide: BorderSide.none,
    );
  }
}
