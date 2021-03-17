import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../../config/Config.dart';

class ApiConnect {
  static Future<Object> get({@required path}) async {
    var response = await http.get('${Config.API_URL}$path');
    return response.body;
  }

  static Future<Object> post(
      {@required String path, @required Object data}) async {
    var response = await http.post(
      '${Config.API_URL}$path',
      body: jsonEncode(data),
      headers: {HttpHeaders.contentTypeHeader: ('application/json')},
    );
    return response.body;
  }
}
