import 'package:flutter/material.dart';
import 'package:project_app/core/models/Time.dart';

class TimeListSection extends StatefulWidget {
  @override
  _TimeListSectionState createState() => _TimeListSectionState();
}

class _TimeListSectionState extends State<TimeListSection> {

  List<Time> times = List.generate(
    5,
        (index) => new Time(
      id: index,
      fieldId: 5,
      userId: null,
      startTime: 'Start:$index',
      endTime: 'End:$index',
      status: false,
    ),
  );

  final GlobalKey<RefreshIndicatorState> _refresh =
  GlobalKey<RefreshIndicatorState>();

  @override
  Widget build(BuildContext context) {
    Size sized = MediaQuery.of(context).size;
    return Column(
      children: [
        Expanded(
          child: RefreshIndicator(
            key: _refresh,
            child: ListView.builder(
              itemCount: times.length,
              itemBuilder: (context, index) => CardTime(
                isTime: times[index],
                onPressed: () async => await _onPressed(index),
              ),
            ),
            onRefresh: _handleRefresh,
          ),
        ),
      ],
    );
  }

  Future _onPressed(int index) {
    return showDialog(
      context: context,
      builder: (BuildContext context) => CustomDialog(
        onOkPressed: () {
          Time _time = times[index];
          _time.userId = 999;
          _time.status = true;
          Navigator.pop(context);
          setState(() {});
        },
      ),
    );
  }

  Future<Null> _handleRefresh() async {
    _timesGenerator();
    await Future.delayed(Duration(seconds: 1));
    setState(() {});
    return null;
  }

  void _timesGenerator() {
    times = List.generate(
      5,
          (index) => new Time(
        id: index,
        fieldId: 5,
        userId: null,
        startTime: 'Start:$index',
        endTime: 'End:$index',
        status: false,
      ),
    );
  }
}

class CustomDialog extends StatelessWidget {
  final VoidCallback onOkPressed;

  const CustomDialog({
    Key key,
    this.onOkPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Confirm'),
      content: Text('Please Confirm'),
      actions: [
        FlatButton(
          onPressed: () => Navigator.pop(context),
          child: Text('Cancel'),
        ),
        FlatButton(
          onPressed: onOkPressed,
          child: Text('Ok'),
        ),
      ],
    );
  }
}

class CardTime extends StatelessWidget {
  final VoidCallback onPressed;
  final String time;
  final Time isTime;

  const CardTime({
    Key key,
    @required this.isTime,
    this.time = '',
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size sized = MediaQuery.of(context).size;
    if (isTime.status == true) {}
    return Stack(
      children: [
        Card(
          margin: EdgeInsets.all(10),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${isTime.startTime} - ${isTime.endTime}',
                  style: TextStyle(fontSize: 22, color: Colors.black87),
                ),
                RaisedButton(
                  color: (isTime.status == false)
                      ? Colors.lightGreenAccent
                      : Colors.red,
                  child: Text('Ready'),
                  onPressed: (isTime.status == false) ? onPressed : null,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
