import 'dart:typed_data';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:project_app/core/models/Field.dart';
import 'package:project_app/core/services/FieldServices.dart';
import 'package:project_app/core/services/UserService.dart';
import 'package:project_app/ui/screens/field/create/section_general/section_general.dart';
import 'package:project_app/ui/screens/field/create/section_images/section_images.dart';

class Body extends StatefulWidget {
  final bool? isCreate;
  final int? fieldId;

  const Body({Key? key, this.isCreate, this.fieldId}) : super(key: key);

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
    setData();
    // if (widget.fieldId != null) _downloadImages(widget.fieldId!);
    setState(() {});
  }

  Future<void> setData() async {
    field.userId = field.userId ?? await UserService.getUserId();
    if (widget.fieldId != null)
      field = await FieldServices.findById(widget.fieldId!);
    print(field);
  }

  // Future<void> _downloadImages(int fieldId) async {
  //   // images = [];
  //   // var res = await FieldServices.downloadImages(widget.fieldId!);
  //   images = await FieldServices.downloadImages(widget.fieldId!);
  //   setState(() {});
  // }

  Future<void> _onSubmit() async {
    var res = widget.isCreate!
        ? await FieldServices.create(_formKey, field, images)
        : await FieldServices.update(_formKey, field, images);
    await Future.delayed(Duration(milliseconds: 200));
    print('onSubmit');
    // if (res) Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SectionImages(images: images),
          SectionGeneral(
            field: field,
            onSubmit:() async => await _onSubmit(),
            isCreate: widget.isCreate,
            formKey: _formKey,
          ),
        ],
      ),
    );
  }
}
