import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:project_app/core/apis/Network/TimeNetwork.dart';
import 'package:project_app/core/models/Time.dart';

class TimeService{

  static Future<List<Time>> getFields() async{
    var response = await TimeNetwork.getAll();
    return timesFormJson(response.data);
  }
  static Future<List<Time>> fetchTimeByUserId({@required int userId}) async{
    var response = await TimeNetwork.getByUserId(userId: userId);
    return timesFormJson(response.data);
  }

  static Future<List<Time>> getByFieldId({@required int fieldId}) async {
    var response = await TimeNetwork.getByFieldId(fieldId: fieldId);
    return timesFormJson(response.data);
  }

  static Future<bool> addTime({@required Time time}) async{
    var response = await TimeNetwork.add(time: time);
    return (response.status == 1) ? true : false;
  }

  static Future<bool> delete({@required int id}) async {
    var response = await TimeNetwork.delete(id: id);
    return (response.status == 1) ? true : false;
  }

}