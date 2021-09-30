import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:project_app/core/apis/FieldApi.dart';
import 'package:project_app/core/models/ApiResponse.dart';
import 'package:project_app/core/models/Field.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Config.dart';
import 'AuthService.dart';

class FieldServices {
  static Future<List<Field>> findAll() async {
    ApiResponse response = await FieldApi.findAll();
    List dataList = jsonDecode(jsonEncode(response.data));
    return fieldsFromJson(dataList);
  }

  static Future<Field> findById({@required int? fieldId}) async {
    ApiResponse response = await FieldApi.findById(fieldId!);
    Field field = fieldFromJson(jsonEncode(response.data));
    return field;
  }

  static Future<bool> create(Field? field, List<Uint8List>? images) async {
    print('create');
    bool status = false;
    await FieldApi.create(field).then((value) {
      if (value.status == 1) {
        Field _field = fieldFromJson(jsonEncode(value.data));
        uploadImages(_field.id!, images!);
        status = true;
      }
      print(value);
    });
    return status;
  }

  static Future<bool> deleteById(int fieldId) async {
    print('delete by id');
    bool status = false;
    await FieldApi.delete(fieldId).then((value) {
      if (value.status == 1) {
        status = true;
      }
    });
    return status;
  }

  static Future<bool> update(Field field, List images) async {
    print('update');
    bool status = false;
    await FieldApi.update(field).then((value) {
      if (value.status == 1) {
        Field _field = fieldFromJson(jsonEncode(value.data));
        uploadImages(_field.id!, images);
        status = true;
      }
      print(value);
    });
    return status;
  }

  static Future<void> uploadImages(int fieldId, List images) async {
    FormData data = FormData.fromMap({"fieldId": fieldId});
    for (var i = 0; i < images.length; i++) {
      data.files.addAll([
        MapEntry(
            "files", MultipartFile.fromBytes(images[i], filename: '$i.png')),
      ]);
    }
    await FieldApi.uploadImages(data).then((value) => print(value));
  }


  static Future<List<Field>> getByUserId(int userId) async {
    ApiResponse response = await FieldApi.findByUserId(userId);
    List dataList = jsonDecode(jsonEncode(response.data));
    return fieldsFromJson(dataList);
  }

  static Future<List<Uint8List>> downloadImages(int fieldId) async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    String? token = _pref.getString(AuthService.TOKEN);
    List<Uint8List> images = [];
    var url = Uri.parse("${Config.API_URL}/field/fileNameImages/$fieldId");
    var response = await http.get(url, headers: {
      HttpHeaders.authorizationHeader: token != null ? 'Bearer $token' : ''
    });
    try {
      List fileNames = jsonDecode(response.body);
      if (fileNames.length != 0) {
        for (var fileName in fileNames) {
          String urlImage =
              Config.API_URL + "/field/download-image/" + fileName;
          var url = Uri.parse(urlImage);
          var response = await http.get(url, headers: {
            HttpHeaders.authorizationHeader:
            token != null ? 'Bearer $token' : ''
          });
          if (response.statusCode == 200) {
            images.add(response.bodyBytes);
          }
        }
      }
    } catch (e) {
      print(e);
    }
    return images;
  }

  static Future<String?> firstImageUrl(int fieldId) async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    String? token = _pref.getString(AuthService.TOKEN);
    String? urlImage;
    var url = Uri.parse("${Config.API_URL}/field/fileNameImages/$fieldId");
    var response = await http.get(url, headers: {
      HttpHeaders.authorizationHeader: token != null ? 'Bearer $token' : ''
    });
    try {
      List decode = jsonDecode(response.body);
      if (decode.length != 0) {
        urlImage = Config.API_URL + "/field/download-image/" + decode[0];
        // print(urlImage);
      }
    } catch (e) {
      print(e);
    }
    return urlImage;
  }
}
