import 'dart:convert';
import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:project_app/config/Config.dart';
import 'package:project_app/core/models/Time.dart';
import 'package:project_app/core/services/TimeService.dart';
import 'package:project_app/ui/components/get_image_network.dart';
import 'package:http/http.dart' as http;

import '../../../constants.dart';

class TestScreen extends StatelessWidget {
  static String routeName = '/test_screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // body: FeedJsonData(),
      // body: CustomTimePicker(),
      // body: CustomAppBarListViewButton(),
      // body: TimeListSection(),
      // body: SizePositionPage(),
      // body: SimpleAnimatedList(),
      // body: SectionGreen(),
      body: Body(),
    );
  }
}

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  int count = 1;
  var _photo;
  var _isImage;

  @override
  void initState() {
    getImage();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        imageBox(context: context),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              icon: Icon(Icons.chevron_left_rounded),
              onPressed: leftArrow(),
            ),
            IconButton(
              icon: Icon(Icons.chevron_right_rounded),
              onPressed: rightArrow(),
            ),
          ],
        ),
        RaisedButton(onPressed: () async => await getImage()),
        RaisedButton(onPressed: () => tinypng()),
        Container(
          width: 200,
          height: 200,
          color: Colors.red,
          // child: Image.memory(_photo),
        ),
      ],
    );
  }

  Function rightArrow() {
    return count != 5
        ? () {
            setState(() {
              if (count != 5) {
                count++;
              }
              print(count);
            });
          }
        : null;
  }

  Function leftArrow() {
    return count != 1
        ? () {
            setState(() {
              if (count != 1) {
                count--;
              }
              print(count);
            });
          }
        : null;
  }

  Widget imageBox({@required BuildContext context}) {
    String path = "${Config.API_URL}/testImage/getUserImages?imageName=2.png";
    // String path = "${Config.API_URL}/testImage/getUserImages?imageName=$count.png";
    var isImage = Image.network(path);

    return Container(
      height: 350,
      width: sized(context).width,
      color: Colors.blue,
      padding: EdgeInsets.all(10),
      child: Center(
        child: isImage,
        // child: Image.network(
        //   path,
        //   // ClubService.mainImage(fileName: photosPath),
        //   fit: BoxFit.fill,
        // ),
      ),
    );
  }

  getImage() async {
    var url = "http://localhost:8080/testImage/getUserImages?imageName=5.png";
    var _image = await http.get(url);
    var decode = jsonDecode(_image.body);
    var bytes = utf8.encode(_image.body);
    // Uint8List base64Str = base64.decode(_image.body);
    Uint8List  base64Str = base64Decode(_image.body);
    print(bytes);
    _photo = base64Str;
    print(base64Str);
    // _photo = bytes;
    // print(_photo.toString());
    // print(base64Str);
    // MemoryImage memImage = ;
    // print(memImage);
  }

   tinypng() async {
    final bytes = Uint8List.fromList([
      137, 80, 78, 71, 13, 10, 26, 10, 0, 0, 0, 13, 73, 72, 68, 82, 0, 0, 0,
      1, 0, 0, 0, 1, 8, 6, 0, 0, 0, 31, 21, 196, 137, 0, 0, 0, 10, 73, 68, 65,
      84, 120, 156, 99, 0, 1, 0, 0, 5, 0, 1, 13, 10, 45, 180, 0, 0, 0, 0, 73,
      69, 78, 68, 174, 66, 96, 130 // prevent dartfmt
    ]);

    print(bytes);
    // copy from decodeImageFromList of package:flutter/painting.dart
    final codec = await instantiateImageCodec(bytes);
    final frameInfo = await codec.getNextFrame();
    _isImage = frameInfo.image;
    print(codec);
    // return  frameInfo.image;
  }
}
