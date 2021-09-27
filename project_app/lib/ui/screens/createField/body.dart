import 'dart:convert';
import 'dart:typed_data';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:project_app/constants.dart';
import 'package:project_app/core/apis/ApiConnect.dart';
import 'package:project_app/core/models/Field.dart';
import 'package:project_app/core/services/FieldServices.dart';
import 'package:project_app/core/services/UserService.dart';
import 'package:project_app/ui/components/custom_alert_dialog.dart';
import 'package:project_app/ui/components/custom_dialog_loading.dart';
import 'package:project_app/ui/components/rounded_button.dart';
import 'package:project_app/ui/screens/createField/section_general/section_general.dart';
import 'package:project_app/ui/screens/createField/section_images/section_images.dart';
import 'package:project_app/ui/screens/createField/section_location/section_location.dart';

import 'dialog_loading/dialog_loading.dart';

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
    super.initState();
  }

  Future<bool> fetchData() async {
    setData();
    if (widget.fieldId != null) await _downloadImages();
    await Future.delayed(Duration(milliseconds: 500));
    return true;
  }

  Future<void> setData() async {
    field.userId = field.userId ?? await UserService.getUserId();
    if (widget.fieldId != null)
      field = await FieldServices.findById(fieldId: widget.fieldId!);
    print(field);
  }

  Future<void> _downloadImages() async {
    images.clear();
    images = await FieldServices.downloadImages(widget.fieldId!);
    print('images: ${images.length}');
  }

  Future<bool> _submit() async {
    bool status = false;
    var res = widget.isCreate!
        ? await FieldServices.create(field, images)
        : await FieldServices.update(field, images);
    await Future.delayed(Duration(milliseconds: 1000));
    if (res == true) {
      status = true;
    }
    return status;
  }

  Future<void> _onSubmit() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      var res = await showDialog(
        context: context,
        builder: (context) => DialogLoading(
          onSubmit: _submit(),
        ),
      );
      if (res == true) {
        Navigator.pop(context);
      } else {
        showDialog(
          context: context,
          builder: (context) => CustomAlertDialog(
            title: 'Error',
            content: 'Please change your title name',
            showBtn: false,
          ),
        );
      }
    }
  }

  Widget submitBtn() {
    return RoundedButton(
      text: widget.isCreate! ? 'Create' : 'Update',
      onTap: _onSubmit,
    );
  }

  Widget buildBody() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 8.0),
            SectionImages(images: images),
            SizedBox(height: 10),
            SectionGeneral(
              field: field,
              isCreate: widget.isCreate!,
              formKey: _formKey,
            ),
            SizedBox(height: 10),
            SectionLocation(field: field),
            SizedBox(height: 10),
            submitBtn(),
            SafeArea(child: SizedBox()),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: fetchData(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          return buildBody();
        } else {
          return CustomDialogLoading();
        }
      },
    );
  }
}
