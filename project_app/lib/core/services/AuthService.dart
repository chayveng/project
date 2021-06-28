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

  static Future<bool> login({@required User? user}) async {
    try {
      SharedPreferences _prefs = await SharedPreferences.getInstance();
      _prefs.setString(USERNAME, user!.userName!);
      _prefs.setInt(USER_ID, user.id!);
      _prefs.setBool(IS_LOGIN, true);
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  static Future<bool> logout() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    _prefs.remove(IS_LOGIN);
    await Future<void>.delayed(Duration(seconds: 1));
    return true;
  }
}
