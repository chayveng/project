import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:project_app/config/Config.dart';
import 'package:project_app/core/apis/ApiConnect.dart';
import 'package:project_app/core/apis/UserApi.dart';
import 'package:project_app/core/models/ApiResponse.dart';
import 'package:project_app/core/models/User.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserService {
  static Future<int> getUserId() async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    int userId = _pref.getInt('user_id');
    return userId;
  }

  static Future<User> getById({@required int userId}) async {
    var response = await UserApi.getById(userId: userId);
    return userFromJson(jsonEncode(response.data));
  }

  static Future<bool> update(
      {@required User user, @required Uint8List image}) async {
    print('service update');
    ApiResponse res = await UserApi.update(user: user);
    if (res.status == 1) {
      print('res ture');
      if (image != null) {
        // await addImage(clubId: user.id, image: image);
        await addImage(userId: user.id, image: image);
        return true;
      }
    } else {
      return false;
    }
    // return res.status == 1 ? true : false;
  }

  // Future<void> getUserImage() async {
  //   // String url = '${UserService.pathUserImage(12)}';
  //   String url = '${UserService.pathUserImage(await UserService.getUserId())}';
  //   var res = await http.get(url);
  //   _userImage = res.bodyBytes.isNotEmpty ? res.bodyBytes : null;
  //   // await Future.delayed(Duration(milliseconds: 200), () => setState(() {}));
  //   // print(_userImage);
  // }

  static String pathUserImage(int userId) {
    // return "http://localhost:8080/user/getUserImage?imageName=$userId.png";
    return '${Config.API_URL}/user/getUserImage?imageName=$userId.png';
    // return "${Config.API_URL}/user/getUserImage?imageName==$userId.png";
    // return "${Config.API_URL}/testImage/getUserImage?imageName=$userId.png";
  }

  static Future<void> addImage({
    @required int userId,
    @required Uint8List image,
    // @required File image,
  }) async {
    if (image != null) {
      // String url = '${Config.API_URL}/user/addUserImage/';
      MultipartFile fileImage = MultipartFile.fromBytes(
        image,
        // image.readAsBytesSync(),
        filename: 'file.png',
      );
      Map<String, dynamic> params = {"userId": userId, "fileImage": fileImage};
      FormData formData = FormData.fromMap(params);
      var dio = Dio();
      var response = await ApiConnect.postDIO(
        path: '/user/addUserImage/',
        data: formData,
      );
      print(response);
      print('add user image');
    } else {
      return true;
      print('add user image fail');
    }
  }
}
