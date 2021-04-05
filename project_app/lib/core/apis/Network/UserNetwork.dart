import 'package:flutter/cupertino.dart';
import 'package:project_app/core/models/ApiResponse.dart';
import 'package:project_app/core/models/User.dart';

import 'ApiConnect.dart';


class UserNetwork {
  static Future<ApiResponse> index() async =>
      apiResponseFromJson(await ApiConnect.get(path: '/user/index'));

  static Future<ApiResponse> user({@required int userId}) async =>
      apiResponseFromJson(await ApiConnect.get(path: '/user/user/$userId'));

  static Future<ApiResponse> users() async =>
      apiResponseFromJson(await ApiConnect.get(path: '/user/users'));

  static Future<ApiResponse> dummy({@required int index}) async =>
      apiResponseFromJson(await ApiConnect.get(path: '/user/dummy/$index'));

  static Future<ApiResponse> register({@required User user}) async =>
      apiResponseFromJson(await ApiConnect.post(path:'/user/register',body: user));

  static Future<ApiResponse> login({@required User user}) async =>
      apiResponseFromJson(await ApiConnect.post(path: '/user/login',body: user));

  static Future<ApiResponse> getById({@required int userId}) async =>
      apiResponseFromJson(await ApiConnect.get(path: '/user/getById/$userId'));
  // static Future<ApiResponse> getById({@required int id}) async =>
  //     apiResponseFromJson(await ApiConnect.get(path: '/field/getById/$id'));
}
