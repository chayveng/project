import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:project_app/core/services/AuthService.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Config.dart';

class ApiConnect {
  static Future<Object?> get({@required path}) async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    String? token = _pref.getString(AuthService.TOKEN);
    var url = Uri.parse('${Config.API_URL}$path');
    var response = await http.get(url, headers: {
      HttpHeaders.authorizationHeader: token != null ? 'Bearer $token' : ''
    });
    return utf8.decode(response.bodyBytes);
  }

  static Future<Object?> delete({@required path}) async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    String? token = _pref.getString(AuthService.TOKEN);
    var url = Uri.parse('${Config.API_URL}$path');
    var response = await http.delete(url, headers: {
      HttpHeaders.authorizationHeader: token != null ? 'Bearer $token' : ''
    });
    return utf8.decode(response.bodyBytes);
  }

  static Future<Object?> post({
    @required String? path,
    @required Object? body,
  }) async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    String? token = _pref.getString(AuthService.TOKEN);
    var url = Uri.parse('${Config.API_URL}$path');
    var response =
        await http.post(url, body: jsonEncode(body), headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      HttpHeaders.authorizationHeader: token != null ? 'Bearer $token' : ''
    });
    return utf8.decode(response.bodyBytes);
  }

  static Future<Object?> postDIO({
    @required String? path,
    @required Object? data,
  }) async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    String? token = _pref.getString(AuthService.TOKEN);
    var dio = Dio();
    var response = await dio.post(
      '${Config.API_URL}$path',
      data: data,
      options: Options(headers: {
        HttpHeaders.authorizationHeader: token != null ? 'Bearer $token' : ''
      }),
    );
    return response.statusCode == 200 ? response : null;
  }
}
