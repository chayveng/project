import 'dart:io';

import 'package:flutter/material.dart';
import 'package:project_app/constants.dart';
import 'package:project_app/core/models/Club.dart';
import 'package:project_app/ui/components/rounded_button.dart';
import 'package:project_app/ui/screens/club/club_screen.dart';

class FormCreateClub extends StatefulWidget {
  @override
  _FormCreateClubState createState() => _FormCreateClubState();
}

class _FormCreateClubState extends State<FormCreateClub> {
  var _formKey = GlobalKey<FormState>();

  File isImage;

  Club club = Club();

  String title;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          buildFormTitle(),
          SizedBox(height: 10),
          buildFormDetail(),
          SizedBox(height: 10),
          buildFormMap(),
          SizedBox(height: 10),
          buildFormTel(),
          SizedBox(height: 10),
          buildFormPrice(),
          SizedBox(height: 10),
          buildFormImage(context),
          Text('Choose a picture'),
          SizedBox(height: 15),
          RoundedButton(
            text: 'Create',
            onTap: () {
              if (_formKey.currentState.validate()) {
                _formKey.currentState.save();
                _showDialog();
                print(club.toString());
              }
            },
          ),
        ],
      ),
    );
  }

  TextFormField buildFormTitle() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Title :'),
      validator: (value) {
        if (value.isEmpty) {
          return 'Please enter title.';
        }
        return null;
      },
      onSaved: (input) => club.title = input,
    );
  }

  TextFormField buildFormDetail() {
    return TextFormField(
      maxLines: 5,
      decoration: InputDecoration(hintText: 'detail : '),
      validator: (value) {
        if (value.isEmpty) {
          return 'Please enter detail.';
        }
        return null;
      },
      onSaved: (input) => club.detail = input,
    );
  }

  TextFormField buildFormMap() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Map :'),
      onSaved: (input) => club.googleMap = input,
    );
  }

  TextFormField buildFormTel() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Tel :'),
      onSaved: (input) => club.tel = input,
    );
  }

  TextFormField buildFormPrice() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Price :'),
      onSaved: (input) => club.price = input,
    );
  }

  InkWell buildFormImage(BuildContext context) {
    return InkWell(
      onTap: () {
        print('image');
      },
      child: Container(
        width: sized(context).width,
        height: 250,
        margin: EdgeInsets.all(8),
        child: (isImage == null) ? FlutterLogo() : isImage,
      ),
    );
  }

  Future _showDialog() {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirm'),
          content: Text('Confirm create club.'),
          actions: [
            Row(
              children: [
                FlatButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    "Cancel",
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                FlatButton(
                  onPressed: () {
                    Navigator.pushNamedAndRemoveUntil(
                        context, ClubScreen.routeName, (Route<dynamic> route) => false);
                  },
                  child: Text(
                    "Ok",
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
