import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:project_app/core/models/ApiResponse.dart';
import 'package:project_app/core/models/Field.dart';

import 'ApiConnect.dart';

class FieldApi {
  static Future<ApiResponse> create(Object body) async => apiResponseFromJson(
      await ApiConnect.post(path: '/field/create', body: body));

  static Future<ApiResponse> update(Object body) async => apiResponseFromJson(
      await ApiConnect.post(path: '/field/update', body: body));

  static Future<Object> uploadImages(FormData data) async {
    return await ApiConnect.postDIO(path: '/field/upload-images', data: data);
  }

  static Future<Object> findById(int fieldId) async {
    return apiResponseFromJson(
      await ApiConnect.get(path: '/field/findById/$fieldId'),
    );
  }
  static Future<Object> findAll() async {
    return apiResponseFromJson(
      await ApiConnect.get(path: '/field/findAll'),
    );
  }

  static Future<ApiResponse> findByUserId(int userId) async =>
      apiResponseFromJson(
          await ApiConnect.get(path: '/field/findByUserId/$userId'));
}
