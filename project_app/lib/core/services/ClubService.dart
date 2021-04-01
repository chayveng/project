import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:project_app/config/Config.dart';
import 'package:project_app/core/apis/Network/ClubNetwork.dart';
import 'package:project_app/core/models/Club.dart';

class ClubService {
  static Future<List<Club>> getClubs() async {
    var response = await ClubNetwork.getAll();
    return clubsFormJson(response.data);
  }

  static Future<Club> getByUserId({@required int userId}) async {
    var response = await ClubNetwork.getByUserId(userId: userId);
    if (response.status == 1) {
      return clubFromJson(jsonEncode(response.data));
    } else {
      return new Club();
    }
  }

  static Future<Club> getById({@required int id})async{
    var response = await ClubNetwork.getById(id: id);
    return clubFromJson(jsonEncode(response.data));
  }

  static Future<bool> create(
      {@required Club club, @required File image}) async {
    var response = await ClubNetwork.addClub(club: club);
    if (response.status == 1) {
      Club _club = clubFromJson(jsonEncode(response.data));
      ClubService.addImage(clubId: _club.id, image: image);
      return true;
    } else {
      print('Club exists');
      return false;
    }
  }

  static Future<bool> update(
      {@required Club club, @required File image}) async {
    var response = await ClubNetwork.update(club: club);
    if(response.status == 1){
      if(image != null){
        Club _club = clubFromJson(jsonEncode(response.data));
        ClubService.addImage(clubId: _club.id, image: image);
      }
      return true;
    }else{
      return false;
    }
  }

  static Future<bool> addImage(
      {@required int clubId, @required File image}) async {
    if (image != null) {
      MultipartFile fileImage = MultipartFile.fromBytes(
        image.readAsBytesSync(),
        filename: "filename.png",
      );
      Map<String, dynamic> params = {"clubId": clubId, "fileImage": fileImage};
      FormData formData = FormData.fromMap(params);
      var response = await ClubNetwork.addImage(data: formData);
      return (response.status == 1) ? true : false;
    } else {
      return true;
    }
  }

  static String mainImage({var fileName}) =>
      "${Config.API_URL}/club/images?imageName=$fileName";
}
