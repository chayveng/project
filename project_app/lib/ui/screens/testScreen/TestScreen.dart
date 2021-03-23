import 'dart:ui';

import 'package:flutter/material.dart';

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
  @override
  Widget build(BuildContext context) {
    Size sized = MediaQuery.of(context).size;
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: sized.width,
            height: sized.height * 0.3,
            color: Colors.red,
            child: FlutterLogo(),
          ),
          Container(
            color: Colors.yellow,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Title"),
                Text(
                    "detail ;dlfjaslkjflskdj;lfkjasd;lfjsdl;ddjflsdjflskdfjdslkfjsdlfjdslfjdslfjsdlfjlks"),
              ],
            ),
          ),
          SizedBox(height: 20),
          Stack(
            alignment: AlignmentDirectional.centerStart,
            children: [
              Container(
                padding: EdgeInsets.only(left: 150),
              color: Colors.green,
                width: sized.width,
                height: 120,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 10),
                    Text("Title"),
                    SizedBox(height: 10),
                    Text("detail"),
                    SizedBox(height: 10),
                    Text("time1"),
                    Text("time1"),
                    Text("time1"),
                  ],
                ),
              ),
              Container(
                width: 150,
                height: 150,
                color: Colors.pinkAccent,
                child: FlutterLogo(),
              ),
            ],
          ),

          Container(
            child: Column(
              children: [
              ],
            ),
          ),
        ],
      ),
    );
  }
}
