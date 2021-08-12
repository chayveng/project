import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:project_app/constants.dart';
import 'package:project_app/core/models/Field.dart';
import 'package:project_app/core/models/Time.dart';
import 'package:project_app/core/services/FieldServices.dart';
import 'package:project_app/core/services/TimeService.dart';
import 'package:project_app/core/services/UserService.dart';
import 'package:project_app/ui/screens/booking/components/not_booking.dart';

import 'components/card_info.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  List<Time> times = [];
  List<Field> fields = [];

  @override
  void initState() {
    fetchData();
    super.initState();
  }

  _onMap(String lct) {
    print('go to map');
  }

  Future<void> fetchData() async {
    fields.clear();
    int userId = await UserService.getUserId();
    times = await TimeService.findByUserId(userId);
    List<int> fieldIds =
        List.generate(times.length, (index) => times[index].fieldId!)
            .toSet()
            .toList();
    fieldIds
        .map((e) async => fields.add(await FieldServices.findById(fieldId: e)))
        .toList();
    await Future.delayed(Duration(milliseconds: 300), () => setState(() {}));
  }

  Field getFieldById(int fieldId) {
    Field _field = Field();
    fields.map((e) {
      if (e.id == fieldId) {
        _field = e;
      }
    }).toList();
    return _field;
  }

  Widget sectionInfo() {
    return times.length != 0
        // ? Expanded(
        //   child: ListView.builder(
        //     padding: EdgeInsets.all(0),
        //     itemCount: times.length,
        //       itemBuilder: (context, index) => CardInfo(
        //         field: getFieldById(times[index].fieldId!),
        //         time: times[index],
        //         onMap: _onMap(getFieldById(times[index].fieldId!).location!),
        //       ),
        //     ),
        // )
        ? Column(
            children: [
              ...List.generate(
                times.length,
                (index) => CardInfo(
                  field: getFieldById(times[index].fieldId!),
                  time: times[index],
                  onMap: _onMap(getFieldById(times[index].fieldId!).location!),
                ),
              ),
            ],
          )
        : SizedBox();
  }

  @override
  Widget build(BuildContext context) {
    return times.length != 0
        ? ListView.builder(
            itemBuilder: (context, index) {
              Field field = getFieldById(times[index].fieldId!);
              return CardInfo(
                field: field,
                time: times[index],
                onMap: _onMap(field.location!),
                // onMap: _onMap(getFieldById(times[index].fieldId!).location!),
              );
              // return Container(
              //   width: sized(context).width,
              //   margin: EdgeInsets.only(top: 8.0, left: 8.0, right: 8.0),
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
              //   child: Column(
              //     mainAxisAlignment: MainAxisAlignment.center,
              //     crossAxisAlignment: CrossAxisAlignment.center,
              //     children: [
              //       Text(
              //         'title',
              //         style: TextStyle(
              //           fontWeight: FontWeight.bold,
              //           fontSize: 20,
              //           color: orangeColor,
              //         ),
              //       ),
              //       Row(
              //         mainAxisAlignment: MainAxisAlignment.spaceAround,
              //         children: [
              //           Row(
              //             children: [
              //               Icon(Icons.event_busy),
              //               SizedBox(width: 8),
              //               Text(
              //                 '02-02-2020',
              //                 style: TextStyle(
              //                   // fontWeight: FontWeight.bold,
              //                   fontSize: 18,
              //                 ),
              //               ),
              //             ],
              //           ),
              //           Row(
              //             children: [
              //               Icon(Icons.access_alarm),
              //               SizedBox(width: 8),
              //               Text(
              //                 '12:00 - 23:0',
              //                 style: TextStyle(
              //                   // fontWeight: FontWeight.bold,
              //                   fontSize: 18,
              //                 ),
              //               ),
              //             ],
              //           ),
              //         ],
              //       ),
              //       Row(
              //         mainAxisAlignment: MainAxisAlignment.end,
              //         children: [
              //           Icon(Icons.location_pin),
              //           InkWell(
              //             onTap: (){
              //               print('onTap');
              //             },
              //             child: Text(
              //               'map',
              //               style: TextStyle(
              //                 color: navyPrimaryColor,
              //                 fontSize: 16,
              //                 decoration: TextDecoration.underline,
              //               ),
              //             ),
              //           ),
              //         ],
              //       ),
              //     ],
              //   ),
              // );
            },
          )
        : NotBooking();
  }
}
