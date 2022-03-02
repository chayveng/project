import 'dart:convert';

import 'package:project_app/core/apis/TimeApi.dart';
import 'package:project_app/core/models/ApiResponse.dart';
import 'package:project_app/core/models/Time.dart';

class TimeService{
  static Future<bool> deleteById(int timeId)async{
    var response = await TimeApi.deleteById(timeId);
    return response.status == 1 ? true : false;
  }

  static Future<bool> createAccept(Time time) async{
    var response = await TimeApi.createAccept(time);
    print(response.message);
    return response.status == 1 ? true : false;
  }

  static Future<bool> createNotAccept(Time time) async{
    var response = await TimeApi.createNotAccept(time);
    print(response.message);
    return response.status == 1 ? true : false;
  }

  static Future<List<Time>> findByFieldId(int fieldId) async{
    ApiResponse res = await TimeApi.findByFieldId(fieldId);
    List dataList = jsonDecode(jsonEncode(res.data));
    List<Time> times = timesFromJson(dataList);
    return times;
  }
  static Future<List<Time>> findByUserId(int userId) async{
    ApiResponse res = await TimeApi.findByUserId(userId);
    List dataList = jsonDecode(jsonEncode(res.data));
    List<Time> times = timesFromJson(dataList);
    return times;
  }

  static Future<ApiResponse> update(Time time) async{
    ApiResponse res = await TimeApi.update(time);
    return res;
  }

}