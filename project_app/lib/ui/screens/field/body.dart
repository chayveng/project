import 'dart:convert';
import 'dart:typed_data';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:project_app/config/Config.dart';
import 'package:project_app/constants.dart';

import 'components/custom_appBar.dart';
import 'components/section_detail.dart';
import 'components/section_images.dart';

class Body extends StatefulWidget {
  const Body({Key key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  bool isOwner = false;
  bool isEdit = false;
  List<Uint8List> images = [];

  @override
  void initState() {
    downloadImages();
    super.initState();
  }

  Future<void> downloadImages() async {
    images = [];
    String url = '${Config.API_URL}/club/urlImages/1';
    await http.get(url).then(
      (value) async {
        print(value.body);
        List lst = jsonDecode(value.body);
        for (var res in lst) {
          await http
              .get(res)
              .then((value) => setState(() => images.add(value.bodyBytes)));
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        width: sized(context).width,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomAppBar(
                isOwner: true,
                onEdit: () => setState(() => isEdit = !isEdit),
              ),
              SectionImages(
                isEdit: isEdit,
                images: images,
              ),
              SectionDetail(),
            ],
          ),
        ),
      ),
    );
  }
}
