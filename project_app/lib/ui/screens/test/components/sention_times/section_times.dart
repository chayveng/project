import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:project_app/core/Config.dart';
import 'package:project_app/core/apis/ApiConnect.dart';
import 'package:project_app/core/models/ApiResponse.dart';
import 'package:project_app/core/models/Time.dart';

import '../../../../../constants.dart';

class SectionTimes extends StatefulWidget {
  const SectionTimes({Key? key}) : super(key: key);

  @override
  _SectionTimesState createState() => _SectionTimesState();
}

class _SectionTimesState extends State<SectionTimes> {
  List<Time> times = [];

  String getTimeOnly(String datetime) {
    int index = datetime.indexOf(' ');
    String str = datetime.substring(index, datetime.length);
    return str;
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      width: sized(context).width,
      child: SingleChildScrollView(
        child: Column(
          children: [
            testButton(
              text: 'fetchData',
              onPressed: () async {
                times = [];
                String currentTime = "2020-05-05 03:00:00";
                int fieldId = 99;
                var url = Uri.parse(
                    '${Config.API_URL}/time/testFindByFieldId/$fieldId/$currentTime');
                String path = "/time/testFindByFieldId/$fieldId/$currentTime";
                var apiConnect = await ApiConnect.get(path: path);
                ApiResponse apiResponse =
                apiResponseFromJson(apiConnect.toString());
                List lst = jsonDecode(jsonEncode(apiResponse.data));
                setState(() {
                  times = timesFromJson(lst);
                });
                print(times.length);
              },
            ),
            ...List.generate(
              times.length,
                  (index) {
                return index == 0
                    ? Column(
                  children: [
                    Center(child: Text('By Current Time')),
                    Container(
                      child: Text(
                        '${getTimeOnly(times[index].startTime!)} - ${getTimeOnly(times[index].endTime!)}',
                        // '${times[index].startTime} - ${times[index].endTime}',
                      ),
                    ),
                  ],
                )
                    : Container(
                  child: Text(
                    '${getTimeOnly(times[index].startTime!)} - ${getTimeOnly(times[index].endTime!)}',
                    // '${times[index].startTime} - ${times[index].endTime}',
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
