import 'dart:convert';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:project_app/core/Config.dart';
import 'package:project_app/core/apis/ApiConnect.dart';
import 'package:project_app/core/apis/UserApi.dart';
import 'package:project_app/core/models/ApiResponse.dart';
import 'package:project_app/core/models/User.dart';
import 'package:project_app/core/services/AuthService.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserService {
  static Future<int> getUserId() async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    int userId = _pref.getInt('user_id')!;
    return userId;
  }

  static Future<User> getById({@required int? userId}) async {
    var response = await UserApi.user(userId: userId);
    return userFromJson(jsonEncode(response.data));
  }

  static Future<bool> logout() async {
    await AuthService.logout();
    return true;
  }

  static Future<bool> login({@required User? user}) async {
    print('login');
    var response = await UserApi.login(user: user);
    if (response.status == 1) {
      User _user = userFromJson(jsonEncode(response.data));
      await AuthService.login(user: _user);
      return true;
    } else {
      return false;
    }
  }

  static Future<bool> register({@required User? user}) async {
    print('register');
    var response = await UserApi.register(user: user);
    return response.status == 1 ? true : false;
  }

  static Future<bool?> update({
    @required User? user,
    @required Uint8List? image,
  }) async {
    ApiResponse res = await UserApi.update(user: user);
    if (res.status == 1) {
      if (image != null) {
        await imageUpload(userId: user!.id, image: image);
        return true;
      }
    } else {
      return false;
    }
  }

  static String pathUserImage(int userId) {
    return '${Config.API_URL}/user/getUserImage?imageName=$userId.png';
  }

  static Future<bool?> imageUpload({int? userId, Uint8List? image}) async {
    String url = '${Config.API_URL}/user/image-upload/';
    FormData data = FormData.fromMap({
      "userId": userId,
      "file": MultipartFile.fromBytes(image!, filename: "$userId.png")
    });
    Dio dio = Dio();
    var response = await dio.post(url, data: data);
    print(response);
    return response.statusCode == 200 ? true : false;
  }

  static Future<Uint8List?> imageDownload(int userId) async {
    var url = Uri.parse("${Config.API_URL}/user/image-download/$userId.png");
    var response = await http.get(url);
    return response.statusCode == 200 ? response.bodyBytes : null;
  }
}
