import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:project_app/config/Config.dart';
import 'package:project_app/core/apis/ApiConnect.dart';
import 'package:project_app/core/apis/ClubApi.dart';
import 'package:project_app/core/models/Club.dart';

class ClubService {
  static Future<List<Club>> getClubs() async {
    var response = await ClubApi.getAll();
    return clubsFormJson(response.data);
  }

  static Future<Club> getByUserId({@required int userId}) async {
    var response = await ClubApi.getByUserId(userId: userId);
    if (response.status == 1) {
      return clubFromJson(jsonEncode(response.data));
    } else {
      return new Club();
    }
  }

  static Future<Club> getById({@required int id}) async {
    var response = await ClubApi.getById(id: id);
    return response.status == 1
        ? clubFromJson(jsonEncode(response.data))
        : Club();
  }

  static Future<bool> create(
      {@required Club club, @required File image}) async {
    var response = await ClubApi.create(club: club);
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
    var response = await ClubApi.update(club: club);
    if (response.status == 1) {
      if (image != null) {
        Club _club = clubFromJson(jsonEncode(response.data));
        ClubService.addImage(clubId: _club.id, image: image);
      }
      return true;
    } else {
      return false;
    }
  }

  Future<void> _update({Club club, List<Uint8List> images}) async {
    var response = await ClubApi.update(club: club);
    if (response.status == 1 && images.isNotEmpty)
        await _uploadImages(club.id, images);
  }

  Future<void> _create({Club club, List<Uint8List> images}) async {
    var response = await ClubApi.create(club: club);
    if (response.status == 1 && images.isNotEmpty)
        await _uploadImages(club.id, images);
  }



  Future<void> _uploadImages(int clubId, List<Uint8List>  images) async {
    String url = '${Config.API_URL}/club/image-uploads/';
    FormData data = FormData.fromMap({"clubId": clubId});
    for (int i = 0; i < images.length; i++) {
      data.files.addAll([
        MapEntry(
            "files",
            MultipartFile.fromBytes(
              images[i],
              filename: '$i.png',
            )),
      ]);
    }
    Dio dio = Dio();
    await dio.post(url, data: data);
  }

  Future<List<Uint8List>> _downloadImages(int clubId) async {
    List<Uint8List> images = [];
    String url = '/club/urlImages/$clubId';
    var response = await ApiConnect.get(path: url);
    List urlImages = jsonDecode(response);
    var res = await http.get(urlImages[0]);
    for (var _url in urlImages) {
      await http.get(_url).then((value) => images.add(value.bodyBytes));
    }
    return images;
  }


  // Future<void> _uploadImages(int userId, int clubId) async {
  //   String path = '/my/uploads';
  //   FormData data = FormData.fromMap({"userId": userId, "clubId": clubId});
  //   for (int i = 0; i < images.length; i++) {
  //     data.files.addAll([
  //       MapEntry(
  //           "files",
  //           MultipartFile.fromBytes(
  //             images[i],
  //             filename: '$i.png',
  //           )),
  //     ]);
  //   }
  //   var response = await ApiConnect.postDIO(path: path, data: data);
  //   print(response);
  // }

  // Future<void> _downloadImages(int userId, int clubId) async {
  //   String dirPath = "/my/getFilesName/$userId/$clubId";
  //   ApiResponse res = apiResponseFromJson(await ApiConnect.get(path: dirPath));
  //   setState(() => images.clear());
  //   for (String fileName in res.data) {
  //     String imagePath = "/my/download/$userId/$clubId/$fileName";
  //     var res = await http.get('${Config.API_URL}/$imagePath');
  //     Uint8List _image = res.bodyBytes;
  //     if (_image != null) setState(() => images.add(_image));
  //   }
  // }


    static Future<bool> addImage(
      {@required int clubId, @required File image}) async {
    if (image != null) {
      MultipartFile fileImage = MultipartFile.fromBytes(
        image.readAsBytesSync(),
        filename: "filename.png",
      );
      Map<String, dynamic> params = {"clubId": clubId, "fileImage": fileImage};
      FormData formData = FormData.fromMap(params);
      var response = await ClubApi.addImage(data: formData);
      return (response.status == 1) ? true : false;
    } else {
      return true;
    }
  }

  static String mainImage({var fileName}) =>
      "${Config.API_URL}/club/images?imageName=$fileName";
}
