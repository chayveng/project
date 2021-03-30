import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:project_app/core/apis/Network/TimeNetwork.dart';
import 'package:project_app/core/models/Time.dart';

class TimeService{

  static Future<List<Time>> fetchTimes() async{
    var response = await TimeNetwork.getAll();
    return timesFormJson(response.data);
  }
  static Future<List<Time>> fetchTimeByUserId({@required int userId}) async{
    var response = await TimeNetwork.getByUserId(userId: userId);
    return timesFormJson(response.data);
  }

  static Future<bool> addTime({@required Time time}) async{
    var response = await TimeNetwork.add(time);
    return (response.status == 1) ? true : false;
  }


}