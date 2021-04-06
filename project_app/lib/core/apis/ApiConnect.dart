import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../config/Config.dart';

class ApiConnect {
  static Future<Object> get({@required path}) async {
    var response = await http.get('${Config.API_URL}$path');
    var res = jsonDecode(utf8.decode(response.bodyBytes));
    return jsonEncode(res);
  }

  static Future<Object> post(
      {@required String path, @required Object body}) async {
    var response = await http.post(
      '${Config.API_URL}$path',
      body: jsonEncode(body),
      headers: {HttpHeaders.contentTypeHeader: ('application/json')},
    );
    var res = jsonDecode(utf8.decode(response.bodyBytes));
    return jsonEncode(res);
  }

  static Future<Object> postDIO({
    @required String path,
    @required Object data,
  }) async {
    var dio = Dio();
    Response response = await dio.post('${Config.API_URL}$path',data: data);
    var res = jsonDecode(response.toString());
    return jsonEncode(res);
  }
}
