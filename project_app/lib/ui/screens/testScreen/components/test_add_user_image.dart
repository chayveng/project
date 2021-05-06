import 'dart:io';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project_app/core/apis/ApiConnect.dart';
import 'package:project_app/core/services/UserService.dart';
import 'package:http/http.dart' as http;

import '../../../../constants.dart';


class TestAddUserImage extends StatefulWidget {
  @override
  _TestAddUserImageState createState() => _TestAddUserImageState();
}

class _TestAddUserImageState extends State<TestAddUserImage> {
  Uint8List isImage;
  File _image;
  int userId;

  File imageFile;
  PickedFile pickedFile;
  final picker = ImagePicker();

  @override
  void initState() {
    print(userId);
    getImage();
    super.initState();
  }

  // void setImage() async {
  //   setState(() {
  //     _image = File.fromRawPath(isImage.isEmpty ? null : isImage);
  //     // _image = isImage as File;
  //     print(_image);
  //   });
  // }

  Future<void> chooseImageGallery() async {
    final imagePicker = ImagePicker();
    pickedFile = await imagePicker.getImage(
      source: ImageSource.gallery,
      maxWidth: 480,
      maxHeight: 640,
      imageQuality: 25,
    );

    // imageFile = null;
    // final pickerFile = await picker.getImage(source: ImageSource.gallery);
    // setState(() {
    //   imageFile = File(pickerFile.path);
    //   print(imageFile);
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: sized(context).width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 200,
            height: 200,
            color: Colors.redAccent,
            // child: Image.file(imageFile),
            // child: buildImage(),
          ),
          RaisedButton(
            child: Text('Choose'),
            onPressed: () async => chooseImage(ImageSource.gallery),
          ),
          RaisedButton(
            child: Text('Add Image'),
            onPressed: () async => await addImage(
              userId: await UserService.getUserId(),
              image: _image,
            ),
          ),
          RaisedButton(
            child: Text('gallery'),
            onPressed: () {
              chooseImageGallery();
            },
          ),
          RaisedButton(
            child: Text('show image str'),
            onPressed: () {
              print(_image);
            },
          ),
        ],
      ),
    );
  }

  Future<void> addImage({
    @required int userId,
    @required File image,
  }) async {
    if (isImage != null) {
      MultipartFile fileImage = MultipartFile.fromBytes(image.readAsBytesSync(),
          filename: 'file.png');
      Map<String, dynamic> params = {"userId": userId, "fileImage": fileImage};
      FormData formData = FormData.fromMap(params);
      var dio = Dio();
      var response = await ApiConnect.postDIO(
        path: '/user/addUserImage/',
        data: formData,
      );
      print(response);
      print('add user image');
    } else {
      return true;
      print('ture');
    }
  }

  Widget buildImage() {
    if (isImage != null) {
      return Image.memory(
        isImage,
        fit: BoxFit.cover,
      );
    } else {
      return Icon(
        Icons.person,
        size: 200,
      );
    }
  }

  Future<void> getImage() async {
    // String url = '${UserService.pathUserImage(12)}';
    String url = '${UserService.pathUserImage(await UserService.getUserId())}';
    var res = await http.get(url);
    isImage = res.bodyBytes.isNotEmpty ? res.bodyBytes : null;
    await Future.delayed(Duration(milliseconds: 200), () => setState(() {}));
  }

  Future<void> chooseImage(ImageSource imageSource) async {
    _image = (_image == null) ? null : _image;
    try {
      var image = await ImagePicker.pickImage(
        source: imageSource,
        maxWidth: 800.0,
        maxHeight: 800.0,
        imageQuality: 75,
      );
      setState(() {
        _image = image;
      });
    } catch (e) {
      print("error");
    }
  }
}
enum FileType {
  Gallery,
  Camera,
  Video,
}
