import 'package:flutter/material.dart';
import 'package:project_app/constants.dart';
import 'package:project_app/core/apis/Network/TimeNetwork.dart';
import 'package:project_app/core/models/Club.dart';
import 'package:project_app/core/models/Field.dart';
import 'package:project_app/core/models/Time.dart';
import 'package:project_app/core/services/TimeService.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'components/time_list_section.dart';

class TestScreen extends StatelessWidget {
  static String routeName = '/test_screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   elevation: 0,
      //   title: Text(
      //     'TestScreen',
      //   ),
      // ),

      // body: FeedJsonData(),
      // body: CustomTimePicker(),
      // body: CustomAppBarListViewButton(),
      // body: TimeListSection(),
      body: Body(),
    );
  }
}

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  bool _status = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: sized(context).width,
      child: Column(
        children: [
          GestureDetector(
            onTap: () => setState(() => _status = !_status),
            child: CardField(field: Field()),
          ),
          CardTime(status: _status, times: List<Time>()),
        ],
      ),
    );
  }
}

class CardTime extends StatelessWidget {
  final bool status;
  final List<Time> times;

  const CardTime({
    Key key,
    @required this.status,
    @required this.times,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      color: Colors.yellow,
      height: status ? 200 : 0,
      width: sized(context).width,
      duration: Duration(milliseconds: 100),
      child: status == true ? _listSection() : SizedBox(),
    );
  }

  Widget _listSection() {
    return SingleChildScrollView(
      child: Column(
        children: [
          ...List.generate(times.length, (index) => Text('${times[index].id}')),
        ],
      ),
    );
  }
}

class CardField extends StatelessWidget {
  final Field field;

  const CardField({
    Key key,
   @required this.field,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      width: sized(context).width,
      color: Colors.redAccent,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(field.title),
          Text(field.detail),
          Text(field.price),
        ],
      ),
    );
  }
}
// Future<void> fetchData() async {
//   times = await TimeService.getFields();
//   await Future.delayed(Duration(milliseconds: 200), () => setState(() {}));
//   print(times);
// }
