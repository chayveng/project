import 'dart:convert';
import 'dart:typed_data';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:project_app/config/Config.dart';
import 'package:project_app/constants.dart';
import 'package:project_app/core/apis/ApiConnect.dart';
import 'package:project_app/core/apis/FieldApi.dart';
import 'package:project_app/core/models/ApiResponse.dart';
import 'package:project_app/core/models/Field.dart';
import 'package:project_app/core/services/FieldServices.dart';
import 'package:project_app/ui/screens/field/components/section_general.dart';
import 'package:project_app/ui/screens/field/components/section_time.dart';

import 'components/custom_appBar.dart';
import 'components/section_detail.dart';
import 'components/section_images.dart';

class Body extends StatefulWidget {
  final bool isOwner;
  final int fieldId;

  const Body({Key key, this.isOwner, this.fieldId}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  Field field = Field();
  bool isEdit = false;
  List<Uint8List> images = [];

  @override
  void initState() {
    fetchData();
    downloadImages();
    super.initState();
  }

  Future<void> fetchData() async {
    field = await FieldServices.findById(widget.fieldId);
    await downloadImages();
  }

  Future<void> downloadImages() async {
    images = [];
    if (widget.fieldId != null) {
      String path = '/field/urlImages/${widget.fieldId}';
      var res = await ApiConnect.get(path: path);
      List urlImages = jsonDecode(res);
      for (var url in urlImages) {
        await http.get(url).then((value) {
          images.add(value.bodyBytes);
          setState(() {});
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: sized(context).width,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomAppBar(
              isOwner: true,
              onEdit: () => setState(() => isEdit = !isEdit),
            ),
            SectionImages(images: images),
            SectionDetail(
              tabBars: ['General', 'Times'],
              tabViews: [SectionGeneral(field: field), SectionTimes(times: [])],
            ),
          ],
        ),
      ),
    );
  }
}
