import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project_app/constants.dart';
import 'package:project_app/core/models/Club.dart';
import 'package:project_app/core/services/ClubService.dart';
import 'package:project_app/core/services/UserService.dart';
import 'package:project_app/ui/components/outline_field.dart';
import 'package:project_app/ui/components/rounded_button.dart';
import 'package:project_app/ui/screens/club/club_screen.dart';

import 'field_image.dart';

class FormCreate extends StatefulWidget {
  final bool isCreate;
  const FormCreate({Key key, this.isCreate}) : super(key: key);

  @override
  _FormCreateState createState() => _FormCreateState(isCreate);
}

class _FormCreateState extends State<FormCreate> {
  final bool isCreate;
  var _formKey = GlobalKey<FormState>();
  Club club = Club();
  File _image;
  Map<String, dynamic> textCtl;
  double heightPadding = 15;
  bool _status = true;

  _FormCreateState(this.isCreate);

  @override
  void initState() {
    isCreated();
    Future.delayed(Duration(milliseconds: 200), () => setState(() {}));
    super.initState();
  }

  Future<void> _onUpdate(BuildContext context) async {
    print('update');
    _formKey.currentState.save();
    if (await ClubService.update(club: club, image: _image)) {
      Club _club = await ClubService.getByUserId(userId: club.userId);
      await Future.delayed(Duration(milliseconds: 1500));
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => ClubScreen(
              clubId: _club.id,
              isOwner: true,
            ),
          ),
              (route) => false);
    } else {
      print('Update Fail');
    }
  }

  Future<void> _onCreate(BuildContext context) async {
    print('create');
    _formKey.currentState.save();
    if (await ClubService.create(club: club, image: _image)) {
      Club _club = await ClubService.getByUserId(userId: club.userId);
      await buildDialogLoading(context, 1500);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ClubScreen(
            clubId: _club.id,
            isOwner: true,
          ),
        ),
      );
    } else {
      print('add fail');
    }
    setState(() {});
  }


  Future<void> chooseImage(ImageSource imageSource) async {
    _image = (_image == null) ? null : _image;
    try {
      var image = await ImagePicker.pickImage(
        source: imageSource,
        maxWidth: 800.0,
        maxHeight: 8000.0,
        imageQuality: 75,
      );
      setState(() {
        _image = image;
      });
    } catch (e) {
      print("error");
    }
  }

  void setDefaultInput() {
    textCtl = {
      'title': TextEditingController(text: club.title),
      'detail': TextEditingController(text: club.detail),
      'open': TextEditingController(text: club.open),
      'price': TextEditingController(text: club.price),
      'tel': TextEditingController(text: club.tel),
    };
  }
  Widget _isCreate({bool isCreate}) => isCreate
      ? RoundedButton(text: 'Update', onTap: () async => _onUpdate(context))
      : RoundedButton(text: 'Create', onTap: () async => _onCreate(context));
  Future<void> isCreated() async {
    var userId = await UserService.getUserId();
    club = await ClubService.getByUserId(userId: userId);
    if (club.userId == null) {
      club.userId = userId;
      _status = !_status;
    }
  }

  @override
  Widget build(BuildContext context) {
    setDefaultInput();
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Column(
          children: [
            FieldImage(
              image: _image,
              photosPath: club.photosPath,
              onTap: () async => chooseImage(ImageSource.gallery),
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: Column(
                children: [
                  SizedBox(height: heightPadding),
                  OutlineField(
                    labelText: "Title",
                    hintText: "Title",
                    controller: textCtl['title'],
                    onSaved: (input) => club.title = input,
                  ),
                  SizedBox(height: heightPadding),
                  OutlineField(
                    labelText: "Detail",
                    hintText: "detail",
                    controller: textCtl['detail'],
                    minLine: 5,
                    onSaved: (input) => club.detail = input,
                  ),
                  SizedBox(height: heightPadding),
                  Row(
                    children: [
                      Expanded(
                        child: OutlineField(
                          labelText: "open-time",
                          hintText: "open-time",
                          controller: textCtl['open'],
                          onSaved: (input) => club.open = input,
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: OutlineField(
                          labelText: "Price",
                          hintText: "price",
                          controller: textCtl['price'],
                          onSaved: (input) => club.price = input,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: heightPadding),
                  OutlineField(
                    labelText: "Tel",
                    hintText: "tel",
                    controller: textCtl['tel'],
                    onSaved: (input) => club.tel = input,
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Container(
                height: 55,
                width: sized(context).width,
                child: _isCreate(isCreate: isCreate),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
