import 'package:flutter/material.dart';
import 'package:project_app/core/models/User.dart';
import 'package:validators/validators.dart';

import '../../../../constants.dart';
import 'card_menu.dart';

class CustomFormField extends StatelessWidget {
  final bool? status;
  final User? user;
  final Map<String, dynamic>? focusNode;

  const CustomFormField({
    Key? key,
    @required this.status,
    @required this.user,
    @required this.focusNode,
  }) : super(key: key);

  Widget tel(BuildContext context) {
    return CardMenu(
      status: status,
      title: user!.tel,
      hintText: 'Tel',
      onSaved: (input) => user!.tel = (input == '') ? null : input,
      keyboardType: TextInputType.number,
      focusNode: focusNode!['tel'],
      onFieldSubmitted: (term) {
        focusNode!['tel'].unfocus();
      },
      validator: (input) {
        if (input.isEmpty) {
          return 'Please enter your tel';
        } else if (!isNumeric(input)) {
          return 'Please enter Numeric';
        } else if (input.length != 10) {
          return 'Tel must be at least 10 characters long';
        } else {
          return null;
        }
      },
    );
  }

  Widget email(BuildContext context) {
    return CardMenu(
      status: status,
      title: user!.email,
      hintText: 'Email',
      onSaved: (input) => user!.email = (input == '') ? null : input,
      focusNode: focusNode!['email'],
      onFieldSubmitted: (term) {
        focusNode!['email'].unfocus();
        FocusScope.of(context).requestFocus(focusNode!['tel']);
      },
      validator: (input) {
        if (!isEmail(input)) {
          return 'Email is not correct.';
        } else {
          return null;
        }
      },
    );
  }

  Widget lastName(BuildContext context) {
    return CardMenu(
      status: status,
      title: user!.lastName,
      hintText: 'LastName',
      onSaved: (input) => user!.lastName = (input == '') ? null : input,
      focusNode: focusNode!['lastName'],
      onFieldSubmitted: (term) {
        focusNode!['lastName'].unfocus();
        FocusScope.of(context).requestFocus(focusNode!['email']);
      },
    );
  }

  Widget firstName(BuildContext context) {
    return CardMenu(
      status: status,
      title: user!.firstName,
      hintText: 'FirstName',
      onSaved: (input) => user!.firstName = input == '' ? null : input,
      focusNode: focusNode!['firstName'],
      onFieldSubmitted: (term) {
        focusNode!['firstName'].unfocus();
        FocusScope.of(context).requestFocus(focusNode!['lastName']);
      },
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
            firstName(context),
            lastName(context),
            email(context),
            tel(context),
          ],
        ),
      ),
    );
  }
}
