import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_app/constants.dart';
import 'package:project_app/core/apis/ApiConnect.dart';
import 'package:project_app/core/models/Field.dart';
import 'package:project_app/core/models/Time.dart';
import 'package:project_app/core/services/UserService.dart';
import 'package:project_app/ui/components/rounded_button.dart';
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
  Time showTime = Time();

  _onSearchByTime(BuildContext context) async {
    // Time to search
    var time = await _getTimeToSearchOverLab(context);
    showTime = time;

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
            await _onSearchByTime(context);
          },
        ),
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.close))],
      ),
      body: SizedBox(
        height: sized(context).height,
        child: Column(
          children: [
            Column(
              children: [
                SizedBox(height: 22),
                Text(
                  '${showTime.startTime != null ? showTime.getDate() : 'วันที่'}',
                  style: TextStyle(
                    fontSize: 20,
                    fontFamily: UiFont,
                  ),
                ),
                Text(
                  showTime.startTime != null
                      ? '${showTime.getStartTime()} - ${showTime.getEndTime()}'
                      : 'เวลา',
                  style: TextStyle(
                    fontSize: 20,
                    fontFamily: UiFont,
                  ),
                ),
                // Button
                SizedBox(height: 8),
                SizedBox(
                  width: sized(context).width * 0.5,
                  height: 50,
                  child: RoundedButton(
                    text: 'ค้นหา',
                    onTap: () {
                      _onSearchByTime(context);
                    },
                  ),
                ),
              ],
            ),
            Expanded(
              child: ListView.builder(
                itemCount: mainFields.length,
                itemBuilder: (context, index) => formItem(index, context),
              ),
            ),
          ],
        ),
      ),
    );
  }

  ListTile formItem(int index, BuildContext context) {
    return ListTile(
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
      },
    );
  }
}
