import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:archive/archive.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project_app/config/Config.dart';
import 'package:project_app/constants.dart';
import 'package:http/http.dart' as http;
import 'package:project_app/core/apis/ApiConnect.dart';
import 'package:project_app/core/models/ApiResponse.dart';

class SectionImages extends StatefulWidget {
  const SectionImages({Key key}) : super(key: key);

  @override
  _SectionImagesState createState() => _SectionImagesState();
}

class _SectionImagesState extends State<SectionImages> {
  int userId = 55;
  int clubId = 11;
  List<Uint8List> images = [];

  @override
  void initState() {
    super.initState();
  }

  Future<void> downLoadImages() async {
    String dirPath = "/my/getFilesName/$userId/$clubId";
    ApiResponse res = apiResponseFromJson(await ApiConnect.get(path: dirPath));
    setState(() => images.clear());
    for (String fileName in res.data) {
      String imagePath = "/my/download/$userId/$clubId/$fileName";
      var res = await http.get('${Config.API_URL}/$imagePath');
      Uint8List _image = res.bodyBytes;
      if (_image != null) setState(() => images.add(_image));
    }
  }

  Future<void> _multiUpload() async {
    String path = '/my/uploads';
    FormData data = FormData.fromMap({"userId": userId, "clubId": clubId});
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
    var response = await ApiConnect.postDIO(path: path, data: data);
    print(response);
    print('multi-upload');
  }

  void _removeImage(int index) {
    print('remove');
    images[index] = null;
    images.remove(null);
    setState(() {});
  }

  Future<void> _chooseImage() async {
    File _image = await chooseImage(ImageSource.gallery);
    if (_image != null) setState(() => images.add(_image.readAsBytesSync()));
  }

  Widget formImage(int index) {
    if (images.length > index) {
      return GestureDetector(
        onTap: () => _removeImage(index),
        child: Container(
          child: Image.memory(
            images[index],
            fit: BoxFit.cover,
          ),
        ),
      );
    } else {
      return GestureDetector(onTap: () async => await _chooseImage());
    }
  }

  Widget sectionImages() {
    return GridView.count(
      crossAxisCount: 3,
      primary: false,
      shrinkWrap: true,
      children: [
        ...List.generate(
          6,
          (index) => Padding(
            padding: const EdgeInsets.all(5),
            child: Container(
              color: Colors.grey.withOpacity(0.35),
              child: formImage(index),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        sectionImages(),
        ElevatedButton(
          onPressed: () async => await _multiUpload(),
          child: Text('multi-upload'),
        ),
        ElevatedButton(
          onPressed: () async => await downLoadImages(),
          child: Text('download multi-files'),
        ),
      ],
    );
  }
}
