import 'dart:convert';
import 'dart:typed_data';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:project_app/core/models/Field.dart';
import 'package:project_app/core/services/FieldServices.dart';
import 'package:project_app/core/services/UserService.dart';
import 'package:project_app/ui/screens/field/create/section_general/section_general.dart';
import 'package:project_app/ui/screens/field/create/section_images/section_images.dart';

class Body extends StatefulWidget {
  final bool isCreate;
  final int fieldId;

  const Body({Key key, this.isCreate, this.fieldId}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final _formKey = GlobalKey<FormState>();
  Field field = Field();
  List<Uint8List> images = [];

  @override
  void initState() {
    fetchData();
    super.initState();
  }

  Future<void> fetchData() async {
    field.userId = widget.fieldId ?? await UserService.getUserId();
    _downloadImages();
    setState(() {});
  }

  Future<void> _downloadImages() async {
    images = [];
    images = await FieldServices.downloadImages(widget.fieldId);
    setState(() {});
    // images = await FieldServices.downloadImages(widget.fieldId);
    // print(images.length);
    // if (widget.fieldId != null) {
    //   images = [];
    //   String path = '/field/urlImages/${widget.fieldId}';
    //   var res = await ApiConnect.get(path: path);
    //   List urlImages = jsonDecode(res);
    //   for (var url in urlImages) {
    //     await http.get(url).then((value) {
    //       setState(() => images.add(value.bodyBytes));
    //     });
    //   }
    // }
  }

  Future<void> _onSubmit() async {
    var res = widget.isCreate
        ? await FieldServices.create(_formKey, field, images)
        : await FieldServices.update(_formKey, field, images);
    if (res) Navigator.pop(context);
    // await _update();
    // await _create();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          ElevatedButton(
            child: Text('print'),
            onPressed: () async {},
          ),
          SectionImages(images: images),
          SectionGeneral(
            field: field,
            onSubmit: () async => await _onSubmit(),
            isCreate: true,
            formKey: _formKey,
          ),
        ],
      ),
    );
  }
}
