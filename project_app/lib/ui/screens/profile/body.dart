import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project_app/constants.dart';
import 'package:project_app/core/models/User.dart';
import 'package:project_app/core/services/UserService.dart';
import 'package:project_app/ui/components/rounded_button.dart';
import 'package:project_app/ui/screens/profile/components/custom_form_field.dart';
import 'package:project_app/ui/screens/profile/components/custom_top_bar.dart';
import 'package:project_app/ui/screens/profile/components/user_image.dart';

class Body extends StatefulWidget {
  final bool? status;
  final Uint8List? userImage;

  Body({
    Key? key,
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
  Uint8List? _image;

  Map<String, dynamic> focusNode = {
    'firstName': FocusNode(),
    'lastName': FocusNode(),
    'email': FocusNode(),
    'tel': FocusNode(),
  };

  @override
  void initState() {
    fetchData();
    super.initState();
  }

  void fetchData() async {
    _user = await UserService.getById(userId: await UserService.getUserId());
    _image = widget.userImage ?? null;
    await Future.delayed(Duration(milliseconds: 100), () => setState(() {}));
    print(_user);
  }

  Future<void> _onUpdate() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      _status = !_status;
      (await UserService.update(user: _user, image: _image))!
          ? fetchData()
          : print('update fail');
      Navigator.pop(context);
    }
  }

  Future<void> _onEdit() async {
    _formKey.currentState!.reset();
    setState(() => _status = !_status);
  }

  Future<void> _chooseImage() async {
    File file = await chooseImage(ImageSource.gallery);
    setState(() => _image = file.readAsBytesSync());
  }

  Widget submitBtn() {
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
    // return Container();
    return Form(
      key: _formKey,
      child: Column(
        children: [
          CustomAppBar(
            status: _status,
            onEdit: _onEdit,
          ),
          SizedBox(height: 30),
          UserImage(
            userName: _user.userName,
            image: _image,
            status: _status,
            onTap: () async => await _chooseImage(),
          ),
          SizedBox(height: 20),
          CustomFormField(
            status: _status,
            user: _user,
            focusNode: focusNode,
          ),
          submitBtn(),
        ],
      ),
    );
  }
}
