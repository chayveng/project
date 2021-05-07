import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project_app/core/models/User.dart';
import 'package:project_app/core/services/UserService.dart';
import 'package:project_app/ui/components/rounded_button.dart';
import 'package:project_app/ui/screens/profile/components/custom_form_field.dart';
import 'package:project_app/ui/screens/profile/components/custom_top_bar.dart';
import 'package:project_app/ui/screens/profile/components/user_image.dart';

class Body extends StatefulWidget {
  final bool status;
  final Uint8List userImage;

  Body({
    Key key,
    @required this.status,
    @required this.userImage,
  }) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final _formKey = GlobalKey<FormState>();
  bool _status = false;
  User _user = User();
  Uint8List _image;
  Map<String, dynamic> focusNode = {
    'firstName': FocusNode(),
    'lastName': FocusNode(),
    'email': FocusNode(),
    'tel': FocusNode(),
  };

  @override
  void initState() {
    fetchData();
    setUserImage();
    super.initState();
  }

  Future<void> _onUpdate() async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      _status = !_status;
      await UserService.update(user: _user, image: _image)
          ? fetchData()
          : print('update fail');
    }
  }

  Future<void> _onEdit() async {
    _formKey.currentState.reset();
    setState(() => _status = !_status);
  }

  void fetchData() async {
    _user = await UserService.getById(userId: await UserService.getUserId());
    await Future.delayed(Duration(milliseconds: 100), () => setState(() {}));
    print(_user);
  }

  Future<void> setUserImage() async {
    _image = widget.userImage ?? null;
    await Future.delayed(Duration(milliseconds: 200), () => setState(() {}));
  }

  Future<void> chooseImage(ImageSource imageSource) async {
    _image = (_image == null) ? null : _image;
    try {
      var image = await ImagePicker.pickImage(
        source: imageSource,
        maxWidth: 800.0,
        maxHeight: 800.0,
        imageQuality: 75,
      );
      setState(() {
        _image = image.readAsBytesSync();
      });
    } catch (e) {
      print("error");
    }
  }

  Widget conFirmButton() {
    return _status
        ? Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: RoundedButton(
              text: 'Confirm',
              onTap: () async => await _onUpdate(),

            ),
          )
        : SizedBox();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          CustomTopBar(
            status: _status,
            onEdit: _onEdit,
          ),
          UserImage(
            userName: _user.userName,
            userImage: widget.userImage,
            image: _image,
            status: _status,
            onTap: () async => chooseImage(ImageSource.gallery),
          ),
          CustomFormField(
            status: _status,
            user: _user,
            focusNode: focusNode,
          ),
          conFirmButton(),
        ],
      ),
    );
  }
}
