import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:project_app/core/models/Field.dart';
import 'package:project_app/core/models/Time.dart';

import '../../../../constants.dart';

class CardInfo extends StatelessWidget {
  final GestureTapCallback? onMap;
  final Field? field;
  final Time? time;

  const CardInfo({
    Key? key,
    @required this.onMap,
    this.field,
    this.time,
  }) : super(key: key);

  // Widget buildTitle() {
  //   return Text(
  //     field!.title!,
  //     style: TextStyle(
  //       fontWeight: FontWeight.bold,
  //       fontSize: 20,
  //       color: orangeColor,
  //     ),
  //   );
  // }

  // Widget buildMap() {
  //   return Row(
  //     mainAxisAlignment: MainAxisAlignment.end,
  //     children: [
  //       Icon(
  //         Icons.location_pin,
  //         color: orangeColor,
  //       ),
  //       InkWell(
  //         onTap: onMap,
  //         child: Text(
  //           'แผนที่',
  //           style: TextStyle(
  //             color: navyPrimaryColor,
  //             fontSize: 16,
  //             decoration: TextDecoration.underline,
  //           ),
  //         ),
  //       ),
  //     ],
  //   );
  // }

  // Widget buildTime() {
  //   return Row(
  //     children: [
  //       Icon(
  //         Icons.access_alarm,
  //         color: Colors.redAccent,
  //       ),
  //       SizedBox(width: 5),
  //       Text(
  //         '${timeGetTime(time!.startTime!)} - ${timeGetTime(time!.endTime!)}',
  //         style: TextStyle(
  //           fontWeight: FontWeight.bold,
  //           fontSize: 18,
  //         ),
  //       ),
  //     ],
  //   );
  // }

  // Widget buildDate() {
  //   return Row(
  //     children: [
  //       Icon(
  //         Icons.event_busy,
  //         color: Colors.pink,
  //       ),
  //       SizedBox(width: 5),
  //       Text(
  //         timeGetDate(time!.startTime!),
  //         style: TextStyle(
  //           fontSize: 18,
  //         ),
  //       ),
  //     ],
  //   );
  // }

  // Widget formInfo() {
  //   return Column(
  //     mainAxisAlignment: MainAxisAlignment.spaceAround,
  //     children: [
  //       buildTitle(),
  //       SizedBox(height: 15),
  //       Row(
  //         mainAxisAlignment: MainAxisAlignment.spaceAround,
  //         children: [
  //           buildDate(),
  //           buildTime(),
  //         ],
  //       ),
  //       buildMap(),
  //     ],
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: sized(context).width,
      margin: EdgeInsets.only(top: 8.0, left: 8.0, right: 8.0),
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        border: Border.all(width: 3, color: orangePrimaryColor),
        borderRadius: BorderRadius.circular(8),
        color: whiteColor,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 7,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          buildTitle(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              buildDate(),
              buildTime(),
            ],
          ),
          buildOnMap(),
        ],
      ),
    );

    // return Container(
    //   width: sized(context).width,
    //   margin: EdgeInsets.all(8),
    //   padding: EdgeInsets.all(8),
    //   decoration: BoxDecoration(
    //     border: Border.all(width: 3, color: orangePrimaryColor),
    //     borderRadius: BorderRadius.circular(8),
    //     color: whiteColor,
    //     boxShadow: [
    //       BoxShadow(
    //         color: Colors.grey.withOpacity(0.5),
    //         spreadRadius: 2,
    //         blurRadius: 7,
    //         offset: Offset(0, 5),
    //       ),
    //     ],
    //   ),
    //   child: formInfo(),
    // );
  }

  Row buildOnMap() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Icon(Icons.location_pin),
        InkWell(
          onTap: () {
            print('onTap');
          },
          child: Text(
            'map',
            style: TextStyle(
              color: navyPrimaryColor,
              fontSize: 16,
              decoration: TextDecoration.underline,
            ),
          ),
        ),
      ],
    );
  }

  Row buildTime() {
    return Row(
      children: [
        Icon(Icons.access_alarm),
        SizedBox(width: 8),
        Text(
          '12:00 - 23:0',
          style: TextStyle(
            // fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
      ],
    );
  }

  Row buildDate() {
    return Row(
      children: [
        Icon(Icons.event_busy),
        SizedBox(width: 8),
        Text(
          timeGetDate(time!.startTime!),
          // '02-02-2020',
          style: TextStyle(
            // fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
      ],
    );
  }

  // String setFormDate(){
  //   DateTime datetime = DateTime.parse('2020-02-02');
  //   return DateFormat('dd-MM-yyyy').format;
  // }

  Text buildTitle() {
    return Text(
      field!.title!,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 20,
        color: orangeColor,
      ),
    );
  }
}
