import 'package:flutter/material.dart';
import 'package:project_app/core/models/ApiResponse.dart';
import 'package:project_app/core/models/Time.dart';
import 'package:project_app/core/services/UserService.dart';

import 'ApiConnect.dart';

class TimeApi {
  static Future<ApiResponse> deleteById(int timeId) async {
    var apiConnect = await ApiConnect.delete(path: '/time/deleteById/$timeId');
    return apiResponseFromJson(apiConnect.toString());
  }
  static Future<ApiResponse> findByFieldId(int fieldId) async {
    var apiConnect = await ApiConnect.get(path: '/time/findByFieldId/$fieldId');
    return apiResponseFromJson(apiConnect.toString());
  }

  static Future<ApiResponse> create(Time time) async {
    var apiConnect = await ApiConnect.post(path: '/time/create', body: time);
    return apiResponseFromJson(apiConnect.toString());
  }

  static Future<ApiResponse> findByUserId(int userId)async{
    var apiConnect = await ApiConnect.get(path: '/time/findByUserId/$userId');
    return apiResponseFromJson(apiConnect.toString());
  }
// apiResponseFromJson(await ApiConnect.post(path: '/time/time', body: time));
// static Future<ApiResponse> index() async =>
//     apiResponseFromJson(await ApiConnect.get(path: '/time/index'));
//
// static Future<ApiResponse> getAll() async =>
//     apiResponseFromJson(await ApiConnect.get(path: '/time/getAll'));
//
// static Future<ApiResponse> getByUserId({@required int userId}) async =>
//     apiResponseFromJson(await ApiConnect.get(path: '/time/getByUserId/$userId'));
//
// static Future<ApiResponse> getByFieldId({@required int fieldId}) async =>
//     apiResponseFromJson(await ApiConnect.get(path: '/time/getByFieldId/$fieldId'));
//
// static Future<ApiResponse> add({@required Time time}) async =>
//     apiResponseFromJson(await ApiConnect.post(path: '/time/add', body: time));
//
// static Future<ApiResponse> delete({@required int id}) async =>
//     apiResponseFromJson(await ApiConnect.get(path: '/time/delete/$id'));
//
// static Future<ApiResponse> booking({@required int timeId, @required int userId}) async =>
//     apiResponseFromJson(await ApiConnect.get(path: '/time/booking/$timeId/$userId'));
//
// static Future<ApiResponse> changeStatus({@required int timeId}) async =>
//     apiResponseFromJson(await ApiConnect.get(path: '/time/changStatus/$timeId'));
}
