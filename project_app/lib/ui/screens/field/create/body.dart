import 'dart:convert';
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:project_app/core/apis/ApiConnect.dart';
import 'package:project_app/core/models/Field.dart';
import 'package:project_app/core/models/FieldLocation.dart';
import 'package:project_app/core/services/FieldServices.dart';
import 'package:project_app/core/services/UserService.dart';
import 'package:project_app/ui/components/custom_alert_dialog.dart';
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
    print('fieldId = ${widget.fieldId}');
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
    // var images = [];
    String path = '/field/urlImages/$fieldId';
    var res = await ApiConnect.get(path: path);
    List urlImages = jsonDecode(res);
    for (var url in urlImages) {
      await http.get(url).then((value) {
        images.add(value.bodyBytes);
        setState(() {});
      });
    }
    print(images.length);
    // images = [];
    // images = await FieldServices.downloadImages(widget.fieldId);
    // setState(() {});
  }

  Future<bool> _submit() async {
    bool status = false;
    var res = widget.isCreate
        ? await FieldServices.create(field, images)
        : await FieldServices.update(field, images);
    await Future.delayed(Duration(milliseconds: 1000));
    // print("submit ${res}");
    if (res == true) {
      status = true;
    }
    return status;
  }

  Future<void> _onSubmit() async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      var res = await showDialog(
        context: context,
        builder: (context) => DialogLoading(
          onSubmit: _submit(),
        ),
      );
      // print("res = ${res}");
      if (res == true) {
        Navigator.pop(context);
      } else {
        showDialog(
          context: context,
          builder: (context) => CustomAlertDialog(
            title: 'Error',
            content: 'Please chang your title name',
            showBtn: false,
          ),
        );
      }
    }
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
            onSubmit: () async => await _onSubmit(),
            isCreate: widget.isCreate,
            formKey: _formKey,
          ),
        ],
      ),
    );
  }
}
