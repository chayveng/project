import 'package:flutter/material.dart';
import 'package:project_app/constants.dart';
import 'package:project_app/core/models/Time.dart';
import 'package:project_app/core/services/TimeService.dart';
import 'package:project_app/core/services/UserService.dart';
import 'package:project_app/ui/screens/booking/components/not_booking.dart';

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
    print(times);
    bool status = times.length == 0 ? false : true ;
    print(status);
    await Future.delayed(Duration(milliseconds: 100), () => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    return times.length == 0 ? NotBooking() : Column(
      children: [
        Container(
          margin: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: creamPrimaryColor,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              sectionImage(context),
              SizedBox(height: 10),
              clubName(),
              fieldName(),
              listSection()
            ],
          ),
        ),
      ],
    );
  }

  Padding fieldName() {
    return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'FieldName',
                style: TextStyle(fontSize: 20),
              ),
            );
  }

  Row clubName() {
    return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'ClubName',
                  style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold),
                ),
              ],
            );
  }

  Container sectionImage(BuildContext context) {
    return Container(
              width: sized(context).width,
              height: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(10),
                    topLeft: Radius.circular(10)),
                color: Colors.redAccent,
              ),
            );
  }

  Widget listSection() {
    return SingleChildScrollView(
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
      padding: const EdgeInsets.only(top: 8.0, left: 8.0, right: 8.0),
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
    );
  }
}
