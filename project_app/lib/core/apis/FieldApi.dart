import 'package:dio/dio.dart';
import 'package:project_app/core/models/ApiResponse.dart';
import 'package:project_app/core/models/Field.dart';

import 'ApiConnect.dart';

class FieldApi {
  static Future<ApiResponse> create(Field? field) async {
    var apiConnect = await ApiConnect.post(path: '/field/create', body: field);
    return apiResponseFromJson(apiConnect.toString());
  }

  static Future<ApiResponse> update(Field? field) async {
    var apiConnect = await ApiConnect.post(path: '/field/update', body: field);
    return apiResponseFromJson(apiConnect.toString());
  }

  static Future<ApiResponse> delete(int fieldId) async {
    var apiConnect = await ApiConnect.get(path: '/field/delete/$fieldId');
    return apiResponseFromJson(apiConnect.toString());
  }
  static Future<Object?> uploadImages(FormData data) async {
    return await ApiConnect.postDIO(path: '/field/upload-images', data: data);

  }

  static Future<ApiResponse> findById(int fieldId) async {
    var apiConnect = await ApiConnect.get(path: '/field/findById/$fieldId');
    return apiResponseFromJson(apiConnect.toString());
  }

  static Future<ApiResponse> findAll() async {
    var apiConnect = await ApiConnect.get(path: '/field/findAll');
    return apiResponseFromJson(apiConnect.toString());
  }

  static Future<ApiResponse> findByUserId(int userId) async {
    var apiConnect = await ApiConnect.get(path: '/field/findByUserId/$userId');
    return apiResponseFromJson(apiConnect.toString());
  }
}
