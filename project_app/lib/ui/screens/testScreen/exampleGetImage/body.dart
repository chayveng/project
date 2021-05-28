import 'dart:io';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:project_app/config/Config.dart';
import 'package:project_app/constants.dart';
import 'package:project_app/core/apis/ApiConnect.dart';
import 'package:project_app/ui/screens/testScreen/exampleGetImage/components/section_images.dart';

class Body extends StatefulWidget {
  const Body({Key key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  Uint8List image;
  List<Uint8List> images;

  Future<void> _chooseImage() async {
    File _image = await chooseImage(ImageSource.gallery);
    if (_image != null) setState(() => image = _image.readAsBytesSync());
  }

  Widget getImageBtn() {
    return ElevatedButton(
      child: Text('get'),
      onPressed: () async {
        String fileName = '0.png';
        String url = '${Config.API_URL}/my/download/$fileName';
        // String url = '${Config.API_URL}/my/download/$fileName/db';
        var res = await http.get(url);
        print(res.runtimeType);
        print(res.bodyBytes);
        image = res.bodyBytes;
        setState(() {});
      },
    );
  }

  Widget addImageBtn() {
    return ElevatedButton(
      child: Text('add'),
      onPressed: () async {
        // String _path = '${Config.API_URL}/my/multi-upload';
        String _path = '/my/multi-upload';
        // String _path = '/my/upload';
        // Dio dio = Dio();
        // await dio.post(_path,data: dataList);
        FormData dataList = _setFormDataList(userId: 12, clubId: 5);
        await ApiConnect.postDIO(path: _path, data: dataList)
            .then((value) => print(value.toString()));
      },
    );
  }

  FormData _setFormData({int userId, int clubId}) {
    Map<String, dynamic> map = {
      "userId": userId,
      "clubId": clubId,
      "file": MultipartFile.fromBytes(image, filename: 'fileName.png')
    };
    FormData data = FormData();
    data = FormData.fromMap(map);
    return data;
  }

  FormData _setFormDataList({int userId, int clubId}) {
    Map<String, dynamic> map = {"userId": userId, "clubId": clubId};
    FormData data = FormData();
    data = FormData.fromMap(map);
    data.files.addAll([
      MapEntry(
        'files',
        MultipartFile.fromBytes(
          image,
          filename: '323.png',
        ),
      ),
    ]);
    // for (int i = 0; i < images.length; i++) {
    //   data.files.addAll([
    //     MapEntry(
    //       'files',
    //       MultipartFile.fromBytes(
    //         images[i],
    //         filename: '.png',
    //       ),
    //     )
    //   ]);
    // }
    return data;
  }

  Widget imageBox(BuildContext context) {
    return GestureDetector(
      onTap: () async => await _chooseImage(),
      child: Container(
        width: sized(context).width,
        height: 300,
        color: Colors.grey.withOpacity(0.35),
        child: image != null
            ? Image.memory(
                image,
                fit: BoxFit.cover,
              )
            : Container(color: Colors.grey.withOpacity(0.35)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // SectionImages(),
              GridView.count(
                shrinkWrap: true,
                primary: false,
                crossAxisCount: 3,
                children: [
                  ...List.generate(6, (index) => Container(color: Colors.green,))
                ],
              ),
              Container(
                color: Colors.redAccent,
                width: sized(context).width,
                height: 50,
              ),
              imageBox(context),
              getImageBtn(),
              addImageBtn(),
            ],
          ),
        ),
      ),
    );
  }
}
