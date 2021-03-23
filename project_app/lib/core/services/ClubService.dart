import 'package:project_app/config/Config.dart';
import 'package:project_app/core/apis/Network/ClubNetwork.dart';
import 'package:project_app/core/models/Club.dart';

class ClubService {
  static Future<List<Club>> fetchClubs() async {
    var response = await ClubNetwork.getAll();
    return clubsFormJson(response.data);
  }

  static String mainImage({var fileName}) =>
      "${Config.API_URL}/club/images?imageName=$fileName";
}
