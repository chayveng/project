import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_app/core/models/ApiResponse.dart';
import 'package:project_app/core/models/User.dart';

import 'ApiConnect.dart';

class UserApi {
  static Future<ApiResponse> index() async {
    var apiConnect = await ApiConnect.get(path: '/user/index');
    ApiResponse apiResponse = apiResponseFromJson(apiConnect.toString());
    return apiResponse;
  }

  static Future<ApiResponse> user({@required int? userId}) async {
    var apiConnect = await ApiConnect.get(path: '/user/getById/$userId');
    return apiResponseFromJson(apiConnect.toString());
  }

  static Future<ApiResponse> users() async {
    var apiConnect = await ApiConnect.get(path: '/user/getAll');
    return apiResponseFromJson(apiConnect.toString());
  }

  static Future<ApiResponse> register({@required User? user}) async {
    var apiConnect = await ApiConnect.post(path: '/user/register', body: user);
    return apiResponseFromJson(apiConnect.toString());
  }

  static Future<ApiResponse> login({@required User? user}) async {
    var apiConnect = await ApiConnect.post(path: '/user/login', body: user);
    return apiResponseFromJson(apiConnect.toString());
  }

  static Future<ApiResponse> update({@required User? user}) async {
    var apiConnect = await ApiConnect.post(path: '/user/update', body: user);
    return apiResponseFromJson(apiConnect.toString());
    // return apiResponseFromJson(
    //     await ApiConnect.post(path: '/user/update', body: user));
  }

//************

// static Future<ApiResponse> addImage({@required FormData data}) async =>
//     apiResponseFromJson(
//         // await ApiConnect.postDIO(path: '/club/addImage/', data: data));
//         await ApiConnect.postDIO(path: '/user/addUserImage/', data: data));

// static Future<ApiResponse> addImage({@required FormData data}) async {
//   return apiResponseFromJson(
//       await ApiConnect.postDIO(path: '/club/addImage/', data: data));
// }
}
