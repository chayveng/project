import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:project_app/constants.dart';
import 'package:project_app/core/Config.dart';
import 'package:http/http.dart' as http;
import 'package:project_app/core/models/ApiResponse.dart';
import 'package:project_app/core/models/Time.dart';

import 'components/card_time.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  List<Time> times = [];




  getTimes() async {
    times = [];
    var url = Uri.parse('${Config.API_URL}/time/findByUserId/0');
    await http.get(url).then((value) {
      ApiResponse response = apiResponseFromJson(value.body);
      var data = response.data;
      List lst = jsonDecode(jsonEncode(data));
      List<Time> _times = timesFormJson(lst);
      setState(() {
        times = _times;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: sized(context).width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ElevatedButton(onPressed: getTimes, child: Text('')),
          ElevatedButton(onPressed: getTimes, child: Text('')),
          ...List.generate(times.length, (index) => Padding(
            padding: const EdgeInsets.all(8.0),
            child: CardTime(time: times[index]),
          )),
          // cardTime(),
        ],
      ),
    );
  }

  String setFormDate(DateTime date) => DateFormat('dd/MM/yyyy').format(date);

  String setFormTime(DateTime time) => DateFormat('HH:mm').format(time);

  String setTimeBetween(String start, String end){
    return '$start - $end';
  }

  // void printFormTime(DateTime start, DateTime end) {
  //   print('${setFormTime(start)} - ${setFormTime(end)}');
  // }
  //
  // void printFormDate(DateTime start, DateTime end) {
  //   print('${setFormDate(start)} - ${setFormDate(end)}');
  // }

  // Widget cardTime(Time time) {
  //   String _date = setFormDate(DateTime.parse(time.startTime!));
  //   String _time = '${setFormTime(DateTime.parse(time.startTime!))} ' +
  //       '-' +
  //       ' ${setFormTime(DateTime.parse(time.startTime!))}';
  //   return Padding(
  //     padding: const EdgeInsets.all(8.0),
  //     child: Container(
  //       child: Row(
  //         mainAxisAlignment: MainAxisAlignment.spaceAround,
  //         children: [
  //           Text(_date),
  //           Text(_time),
  //         ],
  //       ),
  //     ),
  //   );
  // }
}
