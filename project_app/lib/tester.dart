import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:project_app/constants.dart';
import 'package:project_app/core/services/FieldServices.dart';

import 'core/Config.dart';

class TesterScreen extends StatefulWidget {
  const TesterScreen({Key? key}) : super(key: key);

  @override
  _TesterScreenState createState() => _TesterScreenState();
}

class _TesterScreenState extends State<TesterScreen> {
  List<Uint8List> images = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: sized(context).width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () async {
                var _image = await chooseImage(ImageSource.gallery);
                if (_image != null) {
                  setState(() {
                    images.add(_image.readAsBytesSync());
                  });
                }
                print(images.length);
              },
              child: Text('choose image'),
            ),
            ElevatedButton(
              onPressed: () async {
                await FieldServices.uploadImages(111, images);
              },
              child: Text('add images'),
            ),
            ElevatedButton(
              onPressed: () async {
                List<Uint8List> _images = await FieldServices.downloadImages(111);
              },
              child: Text('download images'),
            ),
            ElevatedButton(
              onPressed: () async {
                var url = Uri.parse('${Config.API_URL}/field/urlImages/111');
                var response = await http.get(url);
                List<dynamic> lst = jsonDecode(response.body);
                print(lst.length);
              },
              child: Text('download url images'),
            ),
          ],
        ),
      ),
    );
  }
}
