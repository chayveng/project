import '../models/ApiResponse.dart';
import '../models/Time.dart';
import 'ConnectAPI.dart';

class TimeService {
  static Future<ApiResponse> getAll() async =>
      apiResponseFromJson(await ConnectAPI.get('/time/getAll'));
  static Future<ApiResponse> add(Time time) async =>
      apiResponseFromJson(await ConnectAPI.post('/time/add', time));
}
