import 'package:flutter/material.dart';

import '../../constants.dart';

class OutlineField extends StatelessWidget {
  final String labelText;
  final String hintText;
  final FormFieldSetter onSaved;
  final FormFieldValidator validator;
  final int minLine;
  final TextEditingController controller;

  const OutlineField({
    Key key,
    @required this.labelText,
    @required this.hintText,
    @required this.onSaved,
    this.validator,
    this.minLine,
    this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      maxLines: (minLine == null) ? 1 : minLine,
      decoration: InputDecoration(
        // filled: true,
        // fillColor: grayPrimaryColor.withOpacity(0.5),
        labelText: labelText,
        labelStyle: TextStyle(fontSize: 20, color: greenPrimaryColor),
        hintText: hintText,
        floatingLabelBehavior: FloatingLabelBehavior.always,
        contentPadding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
        focusedBorder: buildOutlineInputBorder(),
        enabledBorder: buildOutlineInputBorder(),
      ),
      onSaved: onSaved,
    );
  }

  OutlineInputBorder buildOutlineInputBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(
        color: greenPrimaryColor.withOpacity(0.5),
        width: 3,
      ),
      gapPadding: 10,
    );
  }
}
