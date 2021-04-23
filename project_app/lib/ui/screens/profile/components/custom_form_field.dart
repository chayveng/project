import 'package:flutter/material.dart';
import 'package:project_app/core/models/User.dart';

import '../../../../constants.dart';
import 'card_menu.dart';

class CustomFormField extends StatelessWidget {
  final bool status;
  final User user;
  final double _sizedOfImageUser = 100;

  const CustomFormField({
    Key key,
    @required this.status,
    @required this.user,
  }) : super(key: key);

  Widget tel() {
    return CardMenu(
      status: status,
      title: user.tel,
      hintText: 'Tel',
      onSaved: (input) => user.tel = (input == '') ? null : input,
    );
  }

  Widget email() {
    return CardMenu(
      status: status,
      title: user.email,
      hintText: 'Email',
      onSaved: (input) => user.email = (input == '') ? null : input,
    );
  }

  Widget lastName() {
    return CardMenu(
      status: status,
      title: user.lastName,
      hintText: 'LastName',
      onSaved: (input) => user.lastName = (input == '') ? null : input,
    );
  }

  Widget firstName() {
    return CardMenu(
      status: status,
      title: user.firstName,
      hintText: 'FirstName',
      onSaved: (input) => user.firstName = input == '' ? null : input,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
        color: creamPrimaryColor,
        borderRadius: BorderRadius.circular(20),
      ),
      width: sized(context).width,
      child: SingleChildScrollView(
        child: Column(
          children: [
            firstName(),
            lastName(),
            email(),
            tel(),
          ],
        ),
      ),
    );
  }
}
