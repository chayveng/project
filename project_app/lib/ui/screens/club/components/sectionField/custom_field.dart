import 'package:flutter/material.dart';

import '../../../../../constants.dart';

class CustomField extends StatelessWidget {
  final String hintText;
  final FormFieldSetter onSaved;
  final FormFieldValidator validator;
  final TextEditingController controller;
  final FocusNode focusNode;
  final ValueChanged onFieldSubmitted;

  const CustomField({
    Key key,
    this.hintText,
    this.onSaved,
    this.validator,
    this.controller,
    this.focusNode,
    this.onFieldSubmitted,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onSaved: onSaved,
      validator: validator,
      controller: controller,
      cursorColor: orangePrimaryColor,
      focusNode: focusNode,
      onFieldSubmitted: onFieldSubmitted,
      decoration: buildInputDecoration(),
    );
  }

  InputDecoration buildInputDecoration() {
    String labelText = hintText[0].toUpperCase() + hintText.substring(1);
    return InputDecoration(
      labelText: labelText,
      labelStyle: TextStyle(color: orangePrimaryColor),
      focusColor: Colors.green,
      enabledBorder: underlineInputBorder(),
      focusedBorder: underlineInputBorder(),
    );
  }

  UnderlineInputBorder underlineInputBorder() {
    return UnderlineInputBorder(
      borderSide: BorderSide(color: orangePrimaryColor),
    );
  }
}
