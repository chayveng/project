import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:project_app/core/apis/Network/UserNetwork.dart';
import 'package:project_app/core/models/User.dart';

class UserService{


  static Future<User> getById({@required int userId}) async {
    var response = await UserNetwork.getById(userId: userId);
    return userFromJson(jsonEncode(response.data));
  }
  // static Future<Field> getFieldById({@required int id})async{
  //   var response = await FieldNetwork.getB`yId(id: id);
  //   return fieldFromJson(jsonEncode(response.data));
  // }

}