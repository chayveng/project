import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../Config.dart';

class ApiConnect {
  static Future<Object?> get({@required path}) async {
    var url = Uri.parse('${Config.API_URL}$path');
    var response = await http.get(url);
    return utf8.decode(response.bodyBytes);
  }

  static Future<Object?> post({
    @required String? path,
    @required Object? body,
  }) async {
    var url = Uri.parse('${Config.API_URL}$path');
    var response = await http.post(
      url,
      // body: body,
      body: jsonEncode(body),
      // headers: {HttpHeaders.contentTypeHeader: ('application/json')},
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    return utf8.decode(response.bodyBytes);
  }

  static Future<Object?> postDIO({
    @required String? path,
    @required Object? data,
  }) async {
    var dio = Dio();
    var response = await dio.post(
      '${Config.API_URL}$path',
      data: data,
    );
    return response.statusCode == 200 ? response : null;
    // var res = jsonDecode(response.toString());
    // return jsonEncode(res);
  }
}
