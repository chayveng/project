import 'dart:convert';
import 'dart:io';
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
    Map res = jsonDecode(response.toString());
    print(res['data']);
    if (res['data'] == 1) {
      await AuthService.setToken(token: res['token']);
      User user = await UserService.getById(userId: res['userId']);
      await AuthService.setUserData(user: user);
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
        await imageUpload(user!.id!, image);
        return true;
      }
    } else {
      return false;
    }
  }

  static Future<bool?> imageUpload(int userId, Uint8List image) async {
    String url = '${Config.API_URL}/user/upload-image';
    FormData data = FormData.fromMap({
      "userId": userId,
      "file": MultipartFile.fromBytes(image, filename: "image.png"),
    });
    SharedPreferences _pref = await SharedPreferences.getInstance();
    String? token = _pref.getString(AuthService.TOKEN);
    Dio dio = Dio();
    var response = await dio.post(
      url,
      data: data,
      options: Options(headers: {
        HttpHeaders.authorizationHeader: token != null ? 'Bearer $token' : ''
      }),
    );
    print(response);
    return response.statusCode == 200 ? true : false;
  }

  static Future<Uint8List?> imageDownload(int userId) async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    String? token = _pref.getString(AuthService.TOKEN);
    var url = Uri.parse("${Config.API_URL}/user/urlImage/$userId");
    var response = await http.get(url, headers: {
      HttpHeaders.authorizationHeader: token != null ? 'Bearer $token' : ''
    });
    if (response.statusCode == 200) {
<<<<<<< HEAD
      var url = Uri.parse("${Config.API_URL}${response.body}");
      var res = await http.get(url, headers: {
=======
      var res = await http.get(Uri.parse(response.body.toString()), headers: {
>>>>>>> master
        HttpHeaders.authorizationHeader: token != null ? 'Bearer $token' : ''
      });
      return res.bodyBytes;
    } else {
      return null;
    }
  }
}
