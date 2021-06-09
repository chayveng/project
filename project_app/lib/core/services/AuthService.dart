import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:project_app/core/apis/UserApi.dart';
import 'package:project_app/core/models/User.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  static final String IS_LOGIN = 'is_login';
  static final String USERNAME = 'user_name';
  static final String USER_ID = 'user_id';

  static Future<bool> isLogin() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    return _prefs.getBool(IS_LOGIN) ?? false;
  }

  static Future<bool> register({@required User? user}) async {
    var res = await UserApi.register(user: user!);
    if (res.status == 1) {
      return true;
    } else {
      return false;
    }
  }

  static Future<bool> login({@required User? user}) async {
    var res = await UserApi.login(user: user!);
    if (res.status == 1) {
      User userData = userFromJson(jsonEncode(res.data));
      SharedPreferences _prefs = await SharedPreferences.getInstance();
      _prefs.setString(USERNAME, user.userName!);
      _prefs.setInt(USER_ID, userData.id!);
      _prefs.setBool(IS_LOGIN, true);
      print(res.message);
      return true;
    } else {
      return false;
    }
  }

  static Future<void> logout() async {
    print('Logged Out');
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    _prefs.remove(IS_LOGIN);
    return await Future<void>.delayed(Duration(seconds: 1));
  }

}
