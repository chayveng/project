import 'package:flutter/material.dart';
import 'package:project_app/constants.dart';
import 'package:project_app/ui/screens/field/section_times/components/card_time.dart';

class BottomSheetBooking extends StatefulWidget {
  const BottomSheetBooking({Key? key}) : super(key: key);

  @override
  _BottomSheetBookingState createState() => _BottomSheetBookingState();
}

class _BottomSheetBookingState extends State<BottomSheetBooking> {
  final Map _time = {
    'hour': List.generate(24, (index) => index),
    'min': List.generate(6, (index) => index * 10),
  };
  Map _current = {'startHour': 0, 'startMin': 0, 'endHour': 0, 'endMin': 0};
  DateTime? startTime;
  DateTime? endTime;
  DateTime start = DateTime.parse('2021-07-03 11:44');
  DateTime end = DateTime.parse('2021-07-03 15:50');

  @override
 void initState(){
    print(_time);
    super.initState();
  }

  Padding buildCardTime(DateTime start, DateTime end) {
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: CardTime(startTime: start, endTime: end),
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
        height: sized(context).height * 0.8,
        color: Colors.white,
        child: Material(
          child: Column(
            children: [
              Padding(
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
              ),
              Expanded(
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
              ),
              Expanded(
                child: Container(
                  height: sized(context).height * 0.4,
                  width: sized(context).width,
                  child: Column(
                    children: [
                      Text('booking'),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          formStart(),
                          formEnd(),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Column formEnd() {
    return Column(
      children: [
        Text('endTime'),
        Text('02/03/2020'),
        Row(
          children: [
            spinner(
                time: 'hour', current: 'endHour', initial: _current['endHour']),
            buildColon(),
            spinner(
                time: 'min', current: 'endMin', initial: _current['endMin']),
          ],
        ),
      ],
    );
  }

  Column formStart() {
    return Column(
      children: [
        Text('startTime'),
        Text('02/03/2020'),
        Row(
          children: [
            spinner(
                time: 'hour',
                current: 'startHour',
                initial: _current['startHour']),
            buildColon(),
            spinner(
                time: 'min',
                current: 'startMin',
                initial: _current['startMin']),
          ],
        ),
      ],
    );
  }

  Padding buildColon() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 1),
      child: Text(':', style: TextStyle(fontSize: 28)),
    );
  }

  String setTowBit(int value) {
    return value.toString().length < 2 ? '0$value' : value.toString();
  }

  Widget spinner({
    @required String? time,
    @required String? current,
    int? initial,
  }) {
    return Container(
      width: 28,
      height: 100,
      child: PageView.builder(
        pageSnapping: true,
        controller: PageController(
          initialPage: initial ?? 0,
          viewportFraction: 0.37,
        ),
        scrollDirection: Axis.vertical,
        onPageChanged: (index) => setState(() => _current[current] = index),
        itemCount: _time[time].length,
        itemBuilder: (BuildContext context, int index) {
          print('$current : ${_time[time][index]}');
          return Center(
            child: Text(
              setTowBit(_time[time][index]),
              style: TextStyle(
                fontSize: 22,
                color: _current[current] == index ? Colors.black : Colors.black38,
              ),
            ),
          );
        },
      ),
    );
  }
}
