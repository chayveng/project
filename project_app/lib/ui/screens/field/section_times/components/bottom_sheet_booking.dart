import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_app/constants.dart';
import 'package:project_app/ui/screens/field/section_times/components/card_time.dart';
import 'package:project_app/ui/screens/field/section_times/components/custom_colon.dart';

class BottomSheetBooking extends StatefulWidget {
  const BottomSheetBooking({Key? key}) : super(key: key);

  @override
  _BottomSheetBookingState createState() => _BottomSheetBookingState();
}

class _BottomSheetBookingState extends State<BottomSheetBooking> {
  final Map _timeSpinner = {
    'hour': List.generate(24, (index) => index),
    'min': List.generate(60, (index) => index),
  };
  Map _current = {'startHour': 0, 'startMin': 0, 'endHour': 0, 'endMin': 0};
  DateTime? startTime, endTime;
  DateTime start = DateTime.parse('2021-07-03 11:44');
  DateTime end = DateTime.parse('2021-07-03 15:50');

  @override
  void initState() {
    super.initState();
  }

  Padding buildCardTime(DateTime start, DateTime end) {
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: CardTime(startTime: start, endTime: end),
    );
  }

  Widget formEnd() {
    return Row(
      children: [
        spinner(time: 'hour', current: 'endHour'),
        CustomColon(size: 3.5),
        spinner(time: 'min', current: 'endMin'),
      ],
    );
  }

  Widget formStart() {
    return Row(
      children: [
        spinner(time: 'hour', current: 'startHour'),
        CustomColon(size: 3.5),
        spinner(time: 'min', current: 'startMin')
      ],
    );
  }

  String setTowBit(String value) => value.length < 2 ? '0$value' : value;

  Widget spinner({
    @required String? time,
    @required String? current,
  }) {
    return Container(
      width: 33,
      height: 100,
      color: Colors.blue.withOpacity(0.5),
      child: PageView.builder(
        pageSnapping: true,
        controller: PageController(
          initialPage: _current[current],
          viewportFraction: 0.37,
        ),
        scrollDirection: Axis.vertical,
        itemCount: _timeSpinner[time].length,
        onPageChanged: (index) => setState(() => _current[current] = index),
        itemBuilder: (BuildContext context, int index) {
          return Center(
            child: Text(
              setTowBit(_timeSpinner[time][index].toString()),
              style: TextStyle(
                fontSize: 22,
                color:
                    _current[current] == index ? Colors.black : Colors.black38,
              ),
            ),
          );
        },
      ),
    );
  }

  Expanded selectorTime(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Text(
            'booking',
            style: TextStyle(

            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              formStart(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Text('-'),
              ),
              formEnd(),
            ],
          ),
        ],
      ),
    );
  }

  Expanded timeList() {
    return Expanded(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              ...List.generate(
                10,
                (index) => buildCardTime(start, end),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Padding backIndicator(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: InkWell(
        onTap: () => Navigator.pop(context),
        child: Container(
          width: sized(context).width * 0.2,
          height: 5,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.black38,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(20),
        topRight: Radius.circular(20),
      ),
      child: Container(
        width: sized(context).width,
        height: sized(context).height * 0.5,
        color: Colors.white,
        child: Material(
          child: Column(
            children: [
              backIndicator(context),
              timeList(),
              selectorTime(context),
              ElevatedButton(
                onPressed: () {
                  print(startTime);
                },
                child: Text('booking'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
