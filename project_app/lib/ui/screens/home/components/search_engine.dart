import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_app/constants.dart';
import 'package:project_app/core/apis/ApiConnect.dart';
import 'package:project_app/core/models/Field.dart';
import 'package:project_app/core/models/Time.dart';
import 'package:project_app/core/services/FieldServices.dart';
import 'package:project_app/core/services/TimeService.dart';
import 'package:project_app/core/services/UserService.dart';
import 'package:project_app/ui/screens/field/field_screen.dart';
import 'package:project_app/ui/screens/home/components/search_by_time.dart';

import 'bottom_sheet_search.dart';

class Search extends SearchDelegate {
  List<Field> recentList = [];
  List<Field> byTimeList = [];

  _onSearchByTime(BuildContext context) async {

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SearchByTime()),
    );
    // byTimeList.clear();
    //
    // // Time to search
    // var time = await _getTimeToSearchOverLab(context);
    // // var time = new Time(
    // //   startTime: '2022-03-02 00:00',
    // //   endTime: '2022-03-02 01:00',
    // // );
    // var resFieldIdIsOverLab = await ApiConnect.post(
    //   path: '/time/getOverLabTimes',
    //   body: time,
    // );
    //
    // // Send time to API, Find fieldId is over lab
    // var resFieldIdIsOverLabData = jsonDecode(resFieldIdIsOverLab.toString());
    // List fieldIdIsOverLab = resFieldIdIsOverLabData['data'];
    //
    // // Get all field
    // var resField = await ApiConnect.get(path: '/field/findAll');
    // var resConvert = jsonDecode(resField.toString());
    // List lst = resConvert['data'];
    // List<Field> fields = fieldsFromJson(lst);
    // List<Field> newFields = [];
    // fields.map((e) {
    //   var count = 0;
    //   fieldIdIsOverLab.map((f) {
    //     if (e.id == f) count++;
    //   }).toList();
    //   if (count == 0) newFields.add(e);
    // }).toList();
    // byTimeList = newFields;
    // // setState(() {
    // //
    // // });
    // print("${newFields.map((e) => e.id).toList()}");
    // print("${newFields.map((e) => e.title).toList()}");
    // print("${recentList.map((e) => e.title).toList()}");
  }

  Future<Time>_getTimeToSearchOverLab(BuildContext context) async {
    int userId = await UserService.getUserId();
    var callBack = await showCupertinoModalPopup(
      context: context,
      builder: (context) => BottomSheetSearch(
        userId: userId,
      ),
    );
    print(callBack);
    return callBack;
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return <Widget>[
      IconButton(
        icon: Icon(Icons.access_time, color: Colors.black),
        onPressed: () async => _onSearchByTime(context),
      ),
      IconButton(
        icon: Icon(
          Icons.close,
          color: navyPrimaryColor,
        ),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(
        Icons.arrow_back,
        color: navyPrimaryColor,
      ),
      onPressed: () {
        Navigator.pop(context);
      },
    );
  }

  late String selectedResult;

  @override
  Widget buildResults(BuildContext context) {
    return Container(
      child: Center(
        child: Text(selectedResult),
      ),
    );
  }

  late final List<Field> listExample;

  Search(this.listExample);

  // List<Field> recentList = [];
  // List<Field> byTimeList = [];

  @override
  Widget buildSuggestions(BuildContext context) {
    List<Field> suggestionList = [];
    query.isEmpty
        ? suggestionList = byTimeList.length == 0 ? recentList : byTimeList
        : suggestionList.addAll(
            listExample.where(
              (element) {
                // field[0].title!.contains(query);
                return element.title!.contains(query);
                // return element.contains(query);
              },
            ),
          );

    return ListView.builder(
      itemCount: suggestionList.length,
      itemBuilder: (context, index) => ListTile(
        title: Text(
          suggestionList[index].title!,
        ),
        onTap: () {
          selectedResult = suggestionList[index].title!;
          print('ssssss');
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => FieldScreen(
                isOwner: false,
                fieldId: suggestionList[index].id!,
              ),
            ),
          );
          // showResults(context);
        },
      ),
    );
  }
}
