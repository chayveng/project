import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:project_app/constants.dart';
import 'package:project_app/core/models/Field.dart';
import 'package:project_app/core/services/FieldServices.dart';
import 'package:project_app/ui/components/custom_dialog_loading.dart';
import 'package:project_app/ui/screens/createField/create_field_screen.dart';
import 'package:project_app/ui/screens/field/section_detail/section_detail.dart';

import 'components/custom_appBar.dart';
import 'components/section_images.dart';

class Body extends StatefulWidget {
  final bool? isOwner;
  final int? fieldId;

  const Body({Key? key, @required this.isOwner, this.fieldId})
      : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  Field field = Field();
  bool isEdit = false;
  List<Uint8List> images = [];

  Future<void> backWord() async {
    await fetchData();
    await Future.delayed(Duration(milliseconds: 300), () => setState(() {}));
  }

  Future<bool> fetchData() async {
    print('fetch');
    field = await FieldServices.findById(fieldId: widget.fieldId!);
    print('findById');
    await downloadImages();
    print('downloadImages');
    await Future.delayed(Duration(milliseconds: 300));
    print('delay');
    return true;
  }

  Future<void> downloadImages() async {
    images.clear();
    images = await FieldServices.downloadImages(widget.fieldId!);
  }

  Future<void> _onEdit() async {
    print('Go to Create Field');
    await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CreateFieldScreen(
              isCreate: false,
              fieldId: field.id!,
            ),
          ),
        ) ??
        backWord();
  }

  Widget buildDetail() {
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          children: [
            SectionImages(images: images),
            SectionDetail(
              field: field,
              isOwner: widget.isOwner!,
              fieldId: widget.fieldId!,
            ),
            SafeArea(top: false, child: SizedBox()),
          ],
        ),
      ),
    );
  }

  Widget buildAppBar() {
    return CustomAppBar(
      title: field.title,
      isOwner: widget.isOwner!,
      onEdit: () async => await _onEdit(),
    );
  }

  Widget buildBody() {
    return Container(
      width: sized(context).width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildAppBar(),
          buildDetail(),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // return buildBody();
    return FutureBuilder(
      future: fetchData(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData == true) {
          return buildBody();
        } else {
          return CustomDialogLoading();
        }
      },
    );
  }
}
