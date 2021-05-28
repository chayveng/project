import 'dart:io';

import 'package:flutter/material.dart';
import 'package:project_app/core/models/Club.dart';
import 'package:project_app/core/services/ClubService.dart';
import 'package:project_app/ui/screens/testScreen/createClub/section_field.dart';
import 'package:project_app/ui/screens/testScreen/createClub/section_image.dart';

class Body extends StatefulWidget {
  final bool isCreate;

  const Body({Key key, this.isCreate}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final _formKey = GlobalKey<FormState>();
  int userId = 101;
  Club club = Club();
  File image;

  @override
  void initState() {
    fetchData();
    super.initState();
  }

  Future<void> fetchData() async {
    // int userId = await UserService.getUserId();
    club = await ClubService.getByUserId(userId: userId);
    club.userId = club.userId ?? userId;
    await Future.delayed(Duration(microseconds: 200), () => setState(() {}));
  }

  Future<void> _onSubmit() async {
    print('submit');
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      widget.isCreate ? print('update') : print('create');
      widget.isCreate
          ? await ClubService.update(club: club, image: image)
          : await ClubService.create(club: club, image: image);
    } else {
      print('validator is error');
    }
  }

  Widget buildFormField() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SectionField(
        club: club,
        isCreate: widget.isCreate,
        onSubmit: () async => await _onSubmit(),
      ),
    );
  }

  Widget buildButtonBack(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(left: 8.0),
        child: InkWell(
          onTap: () => Navigator.pop(context),
          child: Icon(Icons.arrow_back),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Stack(
                children: [
                  Column(
                    children: [
                      SectionImage(isCreate: widget.isCreate),
                      buildFormField(),
                    ],
                  ),
                  buildButtonBack(context),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
