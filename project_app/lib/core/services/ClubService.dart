import 'package:project_app/core/apis/Network/ClubNetwork.dart';
import 'package:project_app/core/models/Club.dart';

class ClubService{
 static Future<List<Club>> fetchClubs() async{
    var response = await ClubNetwork.getAll();
    return clubsFormJson(response.data);
  }

}
