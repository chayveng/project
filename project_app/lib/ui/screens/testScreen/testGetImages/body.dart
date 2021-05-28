import 'dart:io';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project_app/constants.dart';
import 'package:project_app/core/apis/ApiConnect.dart';

class Body extends StatefulWidget {
  const Body({Key key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  List<Uint8List> images = [];
  File image;

  Widget add() {
    return ElevatedButton(
      child: Text('add'),
      onPressed: () async {
        print('add');
        String path = '/my/addImageClub';
        await ApiConnect.postDIO(
          path: path,
          data: await _setFormData(userId: 22, clubId: 11, images: images),
        ).then((value) => print(value));
      },
    );
  }

  Future<FormData> _setFormData(
      {int userId, int clubId, List<Uint8List> images}) async {
    FormData data = (FormData.fromMap({"userId": 100, "clubId": 001}));
    for (var file in images) {
      data.files.addAll([
        MapEntry(
            "fileImages",
            MultipartFile.fromBytes(
              file,
              filename: 'image.png',
            )),
      ]);
    }
    return data;
  }

  Widget buildFormImage() {
    return Column(
      children: [
        Container(
          width: 200,
          height: 200,
          color: Colors.grey.withOpacity(0.35),
          child:
              image != null ? Image.file(image, fit: BoxFit.cover) : SizedBox(),
        ),
        ElevatedButton(
          child: Text('Image'),
          onPressed: () async => await _chooseImage(),
        ),
      ],
    );
  }

  Widget buildFormImages() {
    return Container(
      // color: Colors.red,
      child: Column(
        children: [
          GridView.count(
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
                    child: images.length != 0
                        ? Container(
                            child: GestureDetector(
                              onTap: () {
                                images[index] = null;
                                images.remove(null);
                                setState(() {});
                              },
                              child: images.length > index
                                  ? Container(
                                      child: Image.memory(
                                        images[index],
                                        fit: BoxFit.cover,
                                      ),
                                    )
                                  : SizedBox(),
                            ),
                          )
                        : SizedBox(),
                  ),
                ),
              ),
            ],
          ),
          ElevatedButton(
            child: Text('Images'),
            onPressed: () async => await _chooseImages(),
          ),
        ],
      ),
    );
  }

  Future<void> _chooseImage() async {
    File file = await chooseImage(ImageSource.gallery);
    image = file;
    setState(() {});
  }

  Future<void> _chooseImages() async {
    if (images.length != 6) {
      File file = await chooseImage(ImageSource.gallery);
      if (file != null) {
        images.add(file.readAsBytesSync());
        setState(() {});
        print('images ${images.length}');
      }
    } else {
      print('images ${images.length}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              buildFormImages(),
              SizedBox(width: 10),
              buildFormImage(),
              add(),
            ],
          ),
        ),
      ),
    );
  }
}
