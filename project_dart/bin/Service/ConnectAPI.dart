import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import '../Config.dart';
import '../models/ApiResponse.dart';
import '../models/User.dart';

class ConnectAPI {

  static Future<Object> get(path) async {
    var response = await http.get('${Config.API_URL}${path}');
    return response.body;
  }

  static Future<Object> post(String path, Object data) async {
    var response = await http.post(
      '${Config.API_URL}${path}',
      body: jsonEncode(data),
      headers: {HttpHeaders.contentTypeHeader: ('application/json')},
    );
    return response.body;
  }
}
