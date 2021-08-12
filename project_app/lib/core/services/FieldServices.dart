import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:project_app/core/apis/ApiConnect.dart';
import 'package:project_app/core/apis/FieldApi.dart';
import 'package:project_app/core/models/ApiResponse.dart';
import 'package:project_app/core/models/Field.dart';

import '../Config.dart';

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
    // await FieldApi.create(field).then((value) {
    //   if (value.status == 1) {
    //     Field _field = fieldFromJson(jsonEncode(value.data));
    //     uploadImages(_field.id!, images!);
    //     status = true;
    //   }
    //   print(value);
    // });
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

  static Future<List<Uint8List>> downloadImages(int fieldId) async {
    List<Uint8List> images = [];
    String path = '/field/urlImages/$fieldId';
     Object? res = await ApiConnect.get(path: path);
    if (res != '') {
      List urlImages = jsonDecode(res.toString());
      for (var i = 0; i < urlImages.length; i++) {
        var url = Uri.parse(urlImages[i]);
        var res = await http.get(url);
        images.add(res.bodyBytes);
      }
      return images;
    }else{
      return [];
    }
  }

  static Future<List<Field>> getByUserId(int userId) async {
    ApiResponse response = await FieldApi.findByUserId(userId);
    List dataList = jsonDecode(jsonEncode(response.data));
    return fieldsFromJson(dataList);
  }

  static Future<String> firstImageUrl(int fieldId) async {
    var url = Uri.parse('${Config.API_URL}/field/urlImages/$fieldId');
    var response = await http.get(url);
    List urlImages = jsonDecode(response.body);
    return urlImages[0];
  }
}
