import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:project_app/core/apis/FieldApi.dart';
import 'package:project_app/core/models/Field.dart';

class FieldServices {
  static Future<List<Field>> getFieldClubId(int clubId) async {
    var response = await FieldApi.getByClubId(clubId: clubId);
    return fieldsFormJson(response.data);
  }

  static Future<Field> getFieldById({@required int id})async{
    var response = await FieldApi.getById(id: id);
    return fieldFromJson(jsonEncode(response.data));
  }


  // static Future<List<Field>> fetchFields() async {
  //   var response = await FieldNetwork.getAll();
  //   return fieldsFormJson(response.data);
  // }

  static Future<bool> addField({@required Field field}) async {
    var response = await FieldApi.add(field: field);
    return (response.status == 1) ? true : false;
  }

  static Future<bool> delete({@required int id}) async {
    return await FieldApi.delete(id: id)
        .then((value) => value.status == 1 ? true : false);
  }
}
