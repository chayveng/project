import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:project_app/constants.dart';
import 'package:project_app/core/apis/ApiConnect.dart';
import 'package:project_app/core/services/AuthService.dart';
import 'package:project_app/core/services/FieldServices.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/Config.dart';
import 'core/models/User.dart';

class TesterScreen extends StatefulWidget {
  const TesterScreen({Key? key}) : super(key: key);

  @override
  _TesterScreenState createState() => _TesterScreenState();
}

class _TesterScreenState extends State<TesterScreen> {
  List<Uint8List> images = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: sized(context).width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () async {
                User user = User();
                user.userName = 'dbcooper';
                user.passWord = '1234567890';
                user.tel = '0987654321';
                String token =
                    "eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJkYmNvb3BlciIsIk5BTUUiOiJkYmNvb3BlciIsImV4cCI6MTY0Nzc5NDY0NiwiaXNzIjoibnNjIn0.0Yd8rlbzg5Tj615EYsewdzxkTkFMJ0QQw8y-iG2ZwGEg_w68E-P-lfAnv5K1l4h19G-FGwOtPbqHw-n4zWCihQ";

                // var url = Uri.parse("${Config.API_URL}/field/findAll"); // use get method
                var url = Uri.parse(
                  "${Config.API_URL}/authorize?username=${user.userName}&password=${user.passWord}",
                );
                var response = await http.post(
                  url,
                  headers: {
                    HttpHeaders.authorizationHeader: "Bearer $token",
                  },
                ).then((value) {
                  var decode = jsonDecode(value.body);
                  if (decode['data'] == 1) {
                    print('Token → ${decode['token']}');
                  } else {
                    print(decode);
                  }
                });
              },
              child: Text('tester'),
            ),
            ElevatedButton(
              onPressed: () async {
                String token =
                    "eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJkYmNvb3BlciIsIk5BTUUiOiJkYmNvb3BlciIsImV4cCI6MTY0Nzc5NDY0NiwiaXNzIjoibnNjIn0.0Yd8rlbzg5Tj615EYsewdzxkTkFMJ0QQw8y-iG2ZwGEg_w68E-P-lfAnv5K1l4h19G-FGwOtPbqHw-n4zWCihQ";
                SharedPreferences sharePref = await SharedPreferences.getInstance();
                // print(sharePref.getString(AuthService.TOKEN));
                var url = Uri.parse("${Config.API_URL}/field/findAll"); // use get method
                var res = await FieldServices.findAll();
                print(res);
              },
              child: Text('get'),
            ),
          ],
        ),
      ),
    );
  }
}
