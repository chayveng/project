import 'package:flutter/cupertino.dart';
import 'package:project_app/core/models/ApiResponse.dart';
import 'package:project_app/core/models/Club.dart';

import 'ApiConnect.dart';

class ClubNetwork {
  static Future<ApiResponse> index() async =>
      apiResponseFromJson(await ApiConnect.get(path: '/club/index'));

  static Future<ApiResponse> getById({@required int id}) async =>
      apiResponseFromJson(await ApiConnect.get(path: '/club/getById/$id'));

  static Future<ApiResponse> getByUserId({@required int userId}) async =>
      apiResponseFromJson(
          await ApiConnect.get(path: '/club/getByUserId/$userId'));

  static Future<ApiResponse> getAll() async =>
      apiResponseFromJson(await ApiConnect.get(path: '/club/getAll'));

  static Future<ApiResponse> add({@required Club club}) async =>
      apiResponseFromJson(await ApiConnect.post(path: '/club/add', data: club));

  static Future<ApiResponse> delete({@required int id}) async =>
      apiResponseFromJson(
          await ApiConnect.post(path: '/club/delete/$id', data: null));

  static Future<ApiResponse> update(
          {@required int id, @required Club club}) async =>
      apiResponseFromJson(
          await ApiConnect.post(path: '/club/update/$id', data: club));
}
