import 'package:flutter/material.dart';
import 'package:project_app/constants.dart';
import 'package:project_app/core/models/Time.dart';
import 'package:project_app/core/services/TimeService.dart';
import 'package:project_app/core/services/UserService.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  List<Time> times = new List<Time>();

  @override
  void initState() {
    fetchData();
    super.initState();
  }

  fetchData() async {
    int userId = await UserService.getUserId();
    times = await TimeService.getByUserId(userId: userId);
    await Future.delayed(Duration(milliseconds: 100), () => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: sized(context).width,
      child: Column(
        children: [
          ...List.generate(
            times.length ?? 0,
            (index) => CardTime(
              time: times[index],
              onTap: () {
                print('onTap');
              },
            ),
          ),
        ],
      ),
    );
  }
}

class CardTime extends StatefulWidget {
  final Time time;
  final GestureTapCallback onTap;

  const CardTime({
    Key key,
    @required this.time,
    @required this.onTap,
  }) : super(key: key);

  @override
  _CardTimeState createState() => _CardTimeState();
}

class _CardTimeState extends State<CardTime> {

  @override
  void initState() {
    print('test initState');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top:8.0, left: 8.0,right: 8.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Material(
          color: creamPrimaryColor,
          child: InkWell(
            onTap: widget.onTap,
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.all(10),
                  width: sized(context).width,
                  child: Center(
                    child: Text(
                      '${widget.time.startTime} - ${widget.time.endTime}',
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
