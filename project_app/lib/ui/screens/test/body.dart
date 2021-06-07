import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:project_app/constants.dart';
import 'package:project_app/core/Config.dart';
import 'package:project_app/core/apis/UserApi.dart';
import 'package:project_app/core/models/ApiResponse.dart';
import 'package:project_app/core/models/Field.dart';
import 'package:project_app/core/models/User.dart';
import 'package:project_app/core/services/FieldServices.dart';
import 'package:project_app/ui/components/custom_widget_loading.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  List lst = [];

  void tester() {
    // var res = await FieldServices.firstImageUrl(1);
    // List res = await FieldServices.getByUserId(1);
    // var res = await FieldServices.findById(2);
    // print(res);
    // List<Field> fields = await FieldServices.findAll();
    // print(fields.length);
    // User user = User();
    // user.id = 2;
    // user.userName = "testesttest";
    // user.passWord = "0987654321";
    // var userApi = await UserApi.update(user: user);
    // var userApi = await UserApi.login(user: user);
    // var userApi = await UserApi.register(user: user);
    // var userApi = await UserApi.users();
    // var userApi = await UserApi.user(userId: 1);
    // var userApi = await UserApi.index();
    // print(userApi);
  }

  Future<bool> addData() async {
    for (var i = 0; i < 5; i++) {
      lst.add(i);
      print(i);
      await Future.delayed(Duration(milliseconds: 2000), () {});
    }
    setState(() {});
    return true;
  }

  Future<bool> fetchData() async {
    // await Future.doWhile(() async {
    //   if (lst.length != 0) {
    //     await addData();
    //     return false;
    //   } else {
    //     return true;
    //   }
    // });
    // print('fetchData');
    return true;
  }

  Future<bool> _delay() async{
    if (lst.length > 5) {
      return false;
    } else {
      return true;
    }
  }

  clear() {
    lst.clear();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(child: Text('fetchData'), onPressed: () => fetchData()),
        ElevatedButton(child: Text('clear'), onPressed: () => clear()),
        // Container(
        //   width: sized(context).width,
        //   height: 300,
        //   color: Colors.green,
        //   child: lst.length != 0
        //       ? Column(
        //           mainAxisAlignment: MainAxisAlignment.center,
        //           children: [
        //             ...List.generate(
        //               lst.length,
        //               (index) => Text(
        //                 ' ${lst[index]}',
        //               ),
        //             ),
        //           ],
        //         )
        //       : Text('null'),
        // ),

        Container(
          width: sized(context).width,
          height: 300,
          color: Colors.redAccent,
          child: FutureBuilder(
            future: _delay(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                // if (snapshot.data == true) {
                return Text('finis');
              } else {
                return CustomWidgetLoading();
              }
            },
          ),
        ),
      ],
    );
  }
}
