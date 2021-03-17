import 'package:project_app/core/apis/Network/ApiConnect.dart';
import 'package:project_app/core/models/ApiResponse.dart';
import 'package:project_app/core/models/Time.dart';

class TimeNetwork {
  static Future<ApiResponse> index() async =>
      apiResponseFromJson(await ApiConnect.get(path: '/time/index'));

  static Future<ApiResponse> add(Time time) async =>
      apiResponseFromJson(await ApiConnect.post(path: '/time/add', data: time));
}
