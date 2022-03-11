import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_app/core/apis/ApiConnect.dart';
import 'package:project_app/core/models/Field.dart';
import 'package:project_app/core/models/Time.dart';
import 'package:project_app/core/services/UserService.dart';
import 'package:project_app/ui/screens/field/field_screen.dart';

import 'bottom_sheet_search.dart';

class SearchByTime extends StatefulWidget {
  const SearchByTime({Key? key}) : super(key: key);

  @override
  _SearchByTimeState createState() => _SearchByTimeState();
}

class _SearchByTimeState extends State<SearchByTime> {
  String? title = '';
  List<Field> mainFields = [];

  _onSearchByTime(BuildContext context) async {
    // Time to search
    var time = await _getTimeToSearchOverLab(context);
    // var time = new Time(
    //   startTime: '2022-03-02 00:00',
    //   endTime: '2022-03-02 01:00',
    // );
    var resFieldIdIsOverLab = await ApiConnect.post(
      path: '/time/getOverLabTimes',
      body: time,
    );

    // Send time to API, Find fieldId is over lab
    var resFieldIdIsOverLabData = jsonDecode(resFieldIdIsOverLab.toString());
    List fieldIdIsOverLab = resFieldIdIsOverLabData['data'];

    // Get all field
    var resField = await ApiConnect.get(path: '/field/findAll');
    var resConvert = jsonDecode(resField.toString());
    List lst = resConvert['data'];
    List<Field> _fields = fieldsFromJson(lst);
    List<Field> newFields = [];
    _fields.map((e) {
      var count = 0;
      fieldIdIsOverLab.map((f) {
        if (e.id == f) count++;
      }).toList();
      if (count == 0) newFields.add(e);
    }).toList();
    // fields.clear();
    mainFields = newFields;
    // title = '${time.startTime} - ${time.endTime}';
    // setState(() {
    //
    // });
    print("${newFields.map((e) => e.id).toList()}");
    print("${newFields.map((e) => e.title).toList()}");
    print("${_fields.map((e) => e.title).toList()}");
    setState(() {});
  }

  Future<Time> _getTimeToSearchOverLab(BuildContext context) async {
    int userId = await UserService.getUserId();
    var callBack = await showCupertinoModalPopup(
      context: context,
      builder: (context) => BottomSheetSearch(
        userId: userId,
      ),
    );
    return callBack;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 5,
        title: InkWell(
          child: Text('${title != '' ? title : 'ค้นหาตามเวลา'}'),
          onTap: () async {
            // var time = await _getTimeToSearchOverLab(context);
            await _onSearchByTime(context);
          },
        ),
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.close))],
      ),
      body: ListView.builder(
        itemCount: mainFields.length,
        itemBuilder: (context, index) => ListTile(
          title: Text(
            mainFields[index].title!,
          ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => FieldScreen(
                  isOwner: false,
                  fieldId: mainFields[index].id!,
                ),
              ),
            );
            // showResults(context);
          },
        ),
      )
      // body: Column(
      //   children: [
      //     ...List.generate(mainFields.length, (index) {
      //       return InkWell(
      //         child: Text('${mainFields[index].title}'),
      //         onTap: () {
      //           Navigator.push(
      //             context,
      //             MaterialPageRoute(
      //               builder: (context) => FieldScreen(
      //                 isOwner: false,
      //                 fieldId: mainFields[index].id!,
      //               ),
      //             ),
      //           );
      //         },
      //       );
      //     }).toList(),
      //   ],
      // ),
    );
  }
}
