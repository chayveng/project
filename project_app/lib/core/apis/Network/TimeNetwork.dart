import 'package:flutter/material.dart';
import 'package:project_app/core/apis/Network/ApiConnect.dart';
import 'package:project_app/core/models/ApiResponse.dart';
import 'package:project_app/core/models/Time.dart';

class TimeNetwork {
  static Future<ApiResponse> index() async =>
      apiResponseFromJson(await ApiConnect.get(path: '/time/index'));

  static Future<ApiResponse> getAll() async =>
      apiResponseFromJson(await ApiConnect.get(path: '/time/getAll'));

  static Future<ApiResponse> getByUserId({@required int userId}) async =>
      apiResponseFromJson(await ApiConnect.get(path: '/time/getByUserId/$userId'));

  static Future<ApiResponse> add(Time time) async =>
      apiResponseFromJson(await ApiConnect.post(path: '/time/add', body: time));
}
