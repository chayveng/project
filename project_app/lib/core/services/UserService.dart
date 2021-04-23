import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:project_app/core/apis/UserApi.dart';
import 'package:project_app/core/models/ApiResponse.dart';
import 'package:project_app/core/models/User.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserService{

  static Future<int> getUserId() async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    int userId = _pref.getInt('user_id');
    return userId;
  }

  static Future<User> getById({@required int userId}) async {
    var response = await UserApi.getById(userId: userId);
    return userFromJson(jsonEncode(response.data));
  }

  static Future<bool> update({@required User user}) async{
    ApiResponse res = await UserApi.update(user: user);
    return res.status == 1 ? true : false;
  }

}