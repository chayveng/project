import 'dart:convert';
import 'dart:io';

import 'dart:ui';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project_app/config/Config.dart';
import 'package:project_app/core/apis/Network/ApiConnect.dart';
import 'package:project_app/core/apis/Network/FieldNetwork.dart';
import 'package:project_app/core/models/Field.dart';
import 'package:project_app/core/models/Time.dart';
import 'package:project_app/core/services/ClubService.dart';
import 'package:project_app/core/services/FieldServices.dart';
import 'package:http/http.dart' as http;
import 'package:project_app/core/services/TimeService.dart';
import 'package:project_app/ui/components/outline_field.dart';
import 'package:project_app/ui/screens/testScreen/components/custom_time_picker.dart';

import '../../../constants.dart';
import 'components/feed_json_data.dart';
import 'components/time_list_section.dart';

class TestScreen extends StatelessWidget {
  static String routeName = '/test_screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   elevation: 0,
      //   title: Text(
      //     'TestScreen',
      //     style: TextStyle(color: Colors.black),
      //   ),
      // ),

      // body: FeedJsonData(),
      // body: CustomTimePicker(),
      // body: CustomAppBarListViewButton(),
      // body: TimeListSection(),
      body: Body(),
    );
  }
}

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  var _formKey = GlobalKey<FormState>();
  Time time = new Time(fieldId: 99, userId: 99, status: true);
  List<Time> times = new List<Time>();
  Time _time = new Time(startTime: '12:00', endTime: '13:00');
  Map<String, dynamic> textEditCtl = new Map();

  Future<void> fetchTimes() async {
    times = await TimeService.fetchTimes();
    await Future.delayed(Duration(milliseconds: 1000));
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Opacity(
                opacity: 0.5,
                child: Container(
                  width: 200,
                  height: 200,
                  child: Image.asset(
                    'assets/images/default/image_symbol_landscape.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
