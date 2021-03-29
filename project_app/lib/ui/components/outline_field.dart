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
        labelText: labelText,
        hintText: hintText,
        floatingLabelBehavior: FloatingLabelBehavior.always,
        contentPadding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
        focusedBorder: buildOutlineInputBorder(),
        enabledBorder: buildOutlineInputBorder(),
      ),
      onSaved: onSaved,
    );
  }

  OutlineInputBorder buildOutlineInputBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(20),
      borderSide: BorderSide(color: blackPrimaryColor.withOpacity(0.5)),
      gapPadding: 10,
    );
  }
}
