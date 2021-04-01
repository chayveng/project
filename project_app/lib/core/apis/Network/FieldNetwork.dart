import 'package:flutter/cupertino.dart';
import 'package:project_app/core/models/ApiResponse.dart';
import 'package:project_app/core/models/Field.dart';

import 'ApiConnect.dart';

class FieldNetwork{
  static Future<ApiResponse> index() async =>
      apiResponseFromJson(await ApiConnect.get(path: '/field/index'));

  static Future<ApiResponse> getByClubId({@required int clubId}) async =>
      apiResponseFromJson(await ApiConnect.get(path: '/field/getByClubId/$clubId'));

  static Future<ApiResponse> getById({@required int id}) async =>
  apiResponseFromJson(await ApiConnect.get(path: '/field/getById/$id'));

  static Future<ApiResponse> add({@required Field field}) async =>
      apiResponseFromJson(await ApiConnect.post(path: '/field/add', body: field.toJson()));

  static Future<ApiResponse> delete({@required int id}) async =>
      apiResponseFromJson(await ApiConnect.post(path: '/field/delete/$id', body: null));

  static Future<ApiResponse> getAll() async =>
      apiResponseFromJson(await ApiConnect.get(path: '/field/getAll'));

}