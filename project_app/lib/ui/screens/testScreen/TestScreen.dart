import 'dart:ui';

import 'package:flutter/material.dart';

import 'components/feed_json_data.dart';
import 'components/time_list_section.dart';


class TestScreen extends StatelessWidget {
  static String routeName = '/test_screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text('TestScreen'),
      ),
      body: FeedJsonData(),
      // body: CustomTimePicker(),
      // body: CustomAppBarListViewButton(),
      // body: TimeListSection(),
      // body: Body(),
    );
  }
}