import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:project_app/core/models/Field.dart';
import 'package:project_app/core/models/Time.dart';
import 'package:project_app/ui/screens/field/components/card_time.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../constants.dart';

class Body extends StatefulWidget {
  final Field field;
  final VoidCallback onPressed;

  const Body({Key key, this.field, this.onPressed}) : super(key: key);

  @override
  _BodyState createState() => _BodyState(field, onPressed);
}

class _BodyState extends State<Body> {
  final Field field;
  final VoidCallback onPressed;
  final GlobalKey<RefreshIndicatorState> _refresh =
      GlobalKey<RefreshIndicatorState>();
  List<Time> times;

  _BodyState(
    this.field,
    this.onPressed,
  );

  @override
  void initState() {
    times = generatorTimes();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size sized = MediaQuery.of(context).size;
    return Container(
      color: grayPrimaryColor,
      child: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: RefreshIndicator(
                key: _refresh,
                onRefresh: _handleRefresh,
                child: _listSection(times),
              ),
            ),
          ],
        ),
      ),
    );
  }

  ListView _listSection(List<Time> times) {
    return ListView.builder(
      itemCount: times.length,
      itemBuilder: (context, index) => CardTime(
        time: '${times[index].startTime} - ${times[index].endTime}',
        status: times[index].status,
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) => CustomDialog(
              onPressed: () async {
                SharedPreferences _prefs = await SharedPreferences.getInstance();
                Time _time = times[index];
                _time.userId = _prefs.get('user_id');
                _time.status = true;
                times[index] = _time;
                Navigator.pop(context);
                setState(() {});
              },
            ),
          );
        },
      ),
    );
  }

  Future<Null> _handleRefresh() async {
   times = generatorTimes();
    await Future.delayed(Duration(seconds: 1));
    setState(() {});
    return null;
  }

  List<Time> generatorTimes() {
    return List.generate(
      5,
      (index) => new Time(
        id: index++,
        fieldId: field.id,
        userId: 0,
        startTime: 'start:$index',
        endTime: 'end:$index',
        status: false,
      ),
    );
  }
}

class CustomDialog extends StatelessWidget {
  final VoidCallback onPressed;

  const CustomDialog({Key key, this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('ConFirm'),
      content: Text('please confirm'),
      actions: [
        FlatButton(
          child: Text('Ok'),
          onPressed: onPressed,
        ),
      ],
    );
  }
}
