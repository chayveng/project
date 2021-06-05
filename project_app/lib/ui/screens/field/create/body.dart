import 'dart:convert';
import 'dart:typed_data';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:project_app/core/apis/ApiConnect.dart';
import 'package:project_app/core/models/Field.dart';
import 'package:project_app/core/models/FieldLocation.dart';
import 'package:project_app/core/services/FieldServices.dart';
import 'package:project_app/core/services/UserService.dart';
import 'package:project_app/ui/components/custom_dialog_loading.dart';
import 'package:project_app/ui/screens/field/create/dialog_loading/dialog_loading.dart';
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
  FieldLocation fieldLocation = FieldLocation();
  List<Uint8List> images = [];

  @override
  void initState() {
    fetchData();
    super.initState();
  }

  Future<void> fetchData() async {
    setData();
    if (widget.fieldId != null) _downloadImages(widget.fieldId);
    setState(() {});
  }

  Future<void> setData() async {
    field.userId = field.userId ?? await UserService.getUserId();
    if (widget.fieldId != null)
      field = await FieldServices.findById(widget.fieldId);
    print(field);
  }

  Future<void> _downloadImages(int fieldId) async {
    images = [];
    images = await FieldServices.downloadImages(widget.fieldId);
    setState(() {});
  }

  Future<void> _onSubmit() async {
    if(_formKey.currentState.validate()){
      _formKey.currentState.save();
      var res = widget.isCreate
          ? await FieldServices.create( field, images)
          : await FieldServices.update( field, images);
      await Future.delayed(Duration(milliseconds: 500));
      print(res);
      print('onSubmit');
      if (res) Navigator.pop(context);
    }

    // _formKey.currentState.save();
    // print(field);
    // print(fieldLocation);
    // print(images.length);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SectionImages(images: images),
          SectionGeneral(
            fieldLocation: fieldLocation,
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
