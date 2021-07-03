import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../../constants.dart';
import 'custom_colon.dart';

class DialogTimePicker extends StatefulWidget {
  final DateTime? dateTime;

  const DialogTimePicker({Key? key, this.dateTime}) : super(key: key);

  @override
  _DialogTimePickerState createState() => _DialogTimePickerState();
}

class _DialogTimePickerState extends State<DialogTimePicker> {
  final Map _time = {
    'hour': List.generate(24, (index) => index),
    'min': List.generate(6, (index) => index * 10),
  };
  Map _current = {'hour': 0, 'min': 0};
  DateTime? _dateTime;

  @override
  void initState() {
    if (widget.dateTime != null) {
      _dateTime = widget.dateTime;
    }else{
      _dateTime = DateTime.now();
    }
    setCurrent();
    super.initState();
  }

  setCurrent() {
    print(DateTime.now());
    print(_dateTime);
    int h = _dateTime!.hour;
    int m = _dateTime!.minute;
    while (m % 10 != 0) {
      m++;
    }
    _current['hour'] = _time['hour'].indexOf(h);
    _current['min'] = _time['min'].indexOf(m);
    setState(() {});
  }

  Widget spinner({@required String? time, int? initial}) {
    return PageView.builder(
      pageSnapping: true,
      controller: PageController(
        initialPage: initial ?? 0,
        viewportFraction: 0.37,
      ),
      scrollDirection: Axis.vertical,
      onPageChanged: (index) => setState(() => _current[time] = index),
      itemCount: _time[time].length,
      itemBuilder: (BuildContext context, int index) {
        return Center(
          child: Text(
            setTowBit(_time[time][index]),
            style: TextStyle(
              fontSize: 35,
              color: _current[time] == index ? Colors.black : Colors.black38,
            ),
          ),
        );
      },
    );
  }

  Expanded buildFormPicTime(BuildContext context) {
    return Expanded(
      child: Stack(
        children: [
          Align(
            alignment: Alignment.center,
            child: Container(
              width: sized(context).width,
              height: 160 / 3 - 10,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.orange.withOpacity(0.5),
              ),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Container(
              width: sized(context).width * 0.4,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                      child: spinner(time: 'hour', initial: _current['hour'])),
                  Container(height: 44, child: CustomColon(size: 4)),
                  Expanded(
                      child: spinner(time: 'min', initial: _current['min'])),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildFormPickDate() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () {
              onPickDate(context);
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(width: 2, color: Colors.orange),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                child: Text(
                  setFormDate(_dateTime!),
                  style: TextStyle(fontSize: 22),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<DateTime?> pickDate(BuildContext context) async {
    final newDate = await showDatePicker(
      context: context,
      initialDate: _dateTime!,
      firstDate: DateTime.now(),
      lastDate: DateTime(DateTime.now().year + 5),
    );
    if (newDate == null) return null;
    return newDate;
  }

  Future onPickDate(BuildContext context) async {
    final date = await pickDate(context);
    if (date == null) return;
    setState(() {
      _dateTime = DateTime(date.year, date.month, date.day);
      print(_dateTime);
    });
  }

  String setFormDate(DateTime dateTime) {
    String formattedDate = DateFormat('dd-MM-yyyy').format(dateTime);
    return formattedDate;
  }

  String setTowBit(int value) {
    return value.toString().length < 2 ? '0$value' : value.toString();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Time Picker'),
      content: Container(
        width: sized(context).width,
        height: 170,
        child: Column(
          children: [
            buildFormPickDate(),
            buildFormPicTime(context),
          ],
        ),
      ),
      actions: [
        ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text('cancel'),
        ),
        ElevatedButton(
          onPressed: () async {
            _dateTime = DateTime(
              _dateTime!.year,
              _dateTime!.month,
              _dateTime!.day,
              _time['hour'][_current['hour']],
              _time['min'][_current['min']],
            );
            print(_dateTime);
            Navigator.pop(context, _dateTime);
          },
          child: Text('select'),
        ),
      ],
    );
  }
}