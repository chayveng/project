import 'ConnectAPI.dart';
import '../models/ApiResponse.dart';
import '../models/User.dart';

class UserService {
  static Future<ApiResponse> index() async =>
      apiResponseFromJson(await ConnectAPI.get('/user/index'));

  static Future<ApiResponse> users() async =>
      apiResponseFromJson(await ConnectAPI.get('/user/users'));

  static Future<ApiResponse> dummy(int index) async =>
      apiResponseFromJson(await ConnectAPI.get('/user/dummy/${index}'));

  static Future<ApiResponse> register(User user) async =>
      apiResponseFromJson(await ConnectAPI.post('/user/register', user));

  static Future<ApiResponse> login(User user) async =>
      apiResponseFromJson(await ConnectAPI.post('/user/login', user));

}
