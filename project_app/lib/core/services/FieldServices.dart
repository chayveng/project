import 'package:flutter/foundation.dart';
import 'package:project_app/core/apis/Network/FieldNetwork.dart';
import 'package:project_app/core/models/Field.dart';

class FieldServices {

  static Future<List<Field>> fetchFieldClubId(int clubId) async {
    var response = await FieldNetwork.getByClubId(clubId: clubId);
    return fieldsFormJson(response.data);
  }

  static Future<List<Field>> fetchFields() async{
    var response = await FieldNetwork.getAll();
    return fieldsFormJson(response.data);
  }

  static Future<bool> addField({@required Field field}) async{
    var response = await FieldNetwork.add(field: field);
    return (response.status == 1)? true : false;
  }

}
