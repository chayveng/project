import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:project_app/config/Config.dart';
import 'package:project_app/constants.dart';
import 'package:project_app/core/apis/ApiConnect.dart';
import 'package:project_app/core/models/ApiResponse.dart';

class SectionImages extends StatefulWidget {
  const SectionImages({Key key}) : super(key: key);

  @override
  _SectionImagesState createState() => _SectionImagesState();
}

class _SectionImagesState extends State<SectionImages> {
  int _current = 0;
  List<Uint8List> images = [];
  List<int> list = [1, 2, 3, 4, 5];
  Uint8List image;
  int index = 0;

  @override
  void initState() {
    // _downloadImages();
    super.initState();
  }

  Future<void> _downloadImages() async {
    int userId = 1;
    int clubId = 1;
    String dirPath = "/my/getFilesName/$userId/$clubId";
    ApiResponse res = apiResponseFromJson(await ApiConnect.get(path: dirPath));
    setState(() => images.clear());
    for (String fileName in res.data) {
      String imagePath = "/my/download/$userId/$clubId/$fileName";
      var response = await http.get('${Config.API_URL}/$imagePath');
      var res = jsonDecode(response.body);
      Uint8List _image = res.bodyBytes;
      if (_image != null) setState(() => images.add(_image));
    }
    print(images.length);
    await Future.delayed(Duration(milliseconds: 100), () => setState(() {}));
  }

  Future<void> _remove() async {
    setState(() => images.removeLast());
    print(images.length);
  }

  Future<void> _add() async {
    File _image = await chooseImage(ImageSource.gallery);
    if (_image != null) images.add(_image.readAsBytesSync());
    setState(() {});
    print(images.length);
  }

  Widget boxImage() {
    if (images.length == 0) {
      return Center(child: Text('null'));
    } else if (images[index] != null) {
      return Image.memory(images[index], fit: BoxFit.cover);
    } else {
      return SizedBox();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  child: Text('get image db'),
                  onPressed: () async {
                    String url = 'http://localhost:8080/club/urlImages/1';
                    var response = await http.get(url);
                    List res = jsonDecode(response.body);
                    images = [];
                    for (var _url in res) {
                      await http.get(_url.toString()).then((value) =>
                          setState(() => images.add(value.bodyBytes)));
                    }

                    // image = response.bodyBytes;
                    // setState(() {});
                  },
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  child: Text('upload to db'),
                  onPressed: () async {
                    FormData data = FormData.fromMap({"clubId": 1});
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
                    String path = '/club/image-uploads';
                    var res = await ApiConnect.postDIO(path: path, data: data);
                    print(res);
                  },
                ),
              ],
            ),
            Container(
              width: sized(context).width,
              height: 250,
              color: Colors.yellow,
              child: boxImage(),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon(Icons.arrow_back_ios_rounded),
                  onPressed: () {
                    if (index != 0) setState(() => index = index - 1);
                    print(index);
                  },
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: IconButton(
                    icon: Icon(Icons.remove),
                    onPressed: () async => await _remove(),
                  ),
                ),
                SizedBox(width: 10),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: IconButton(
                    icon: Icon(Icons.add),
                    onPressed: () async => await _add(),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.arrow_forward_ios_rounded),
                  onPressed: () {
                    if (index != images.length - 1)
                      setState(() => index = index + 1);
                    print(index);
                  },
                ),
              ],
            ),
            Container(
              width: sized(context).width,
              height: 250,
              color: Colors.amber,
              child: Column(children: [
                CarouselSlider(
                  options: CarouselOptions(
                      autoPlay: true,
                      // enlargeCenterPage: true,
                      // aspectRatio: 2.0,
                      onPageChanged: (index, reason) {
                        setState(() {
                          _current = index;
                        });
                      }),
                  items: images
                      .map(
                        (item) => Container(
                          width: double.infinity,
                          height: double.infinity,
                          child: Image.memory(item, fit: BoxFit.cover),
                        ),
                      )
                      .toList(),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: images.map((url) {
                    int index = images.indexOf(url);
                    return Container(
                      width: 8.0,
                      height: 8.0,
                      margin:
                          EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: _current == index
                            ? Color.fromRGBO(0, 0, 0, 0.9)
                            : Color.fromRGBO(0, 0, 0, 0.4),
                      ),
                    );
                  }).toList(),
                ),
              ]),
            ),

            // ElevatedButton(
            //   child: Text('print'),
            //   onPressed: () {
            //     print('images: ${images.length}');
            //     print('index: $index');
            //   },
            // ),
          ],
        ),
      ),
    );
  }
}
