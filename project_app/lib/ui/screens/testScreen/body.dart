import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:project_app/config/Config.dart';
import 'package:project_app/core/models/Field.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          ElevatedButton(
            child: Text('submit'),
            onPressed: () async {
              Field field = Field();
              field.userId = 1;
              field.title = "the arena";
              var jsonData = jsonEncode(field);
              // var jsonData = fieldToJson(field);
              Map map = {
                "userId": 1,
                "title": "yreoiwuroiweu",
                "detail": "is arena"
              };
              var jsonMap = jsonEncode(map);
              var res = await http.post(
                '${Config.API_URL}/field/create',
                headers: <String, String>{
                  'Content-Type': 'application/json; charset=UTF-8',
                },
                body: jsonMap,
                // body: jsonData,
              );
              print(res.body);
            },
          ),
        ],
      ),
    );
  }
}
