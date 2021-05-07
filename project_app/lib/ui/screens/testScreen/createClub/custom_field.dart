import 'package:flutter/material.dart';
import 'package:project_app/constants.dart';

class CustomField extends StatelessWidget {
  final String labelText;
  final String hintText;
  final FormFieldSetter onSaved;
  final FormFieldValidator validator;
  final TextEditingController controller;
  final FocusNode focusNode;
  final ValueChanged onFieldSubmitted;
  final TextInputType keyboardType;
  final int maxLine;

  const CustomField({
    Key key,
    this.labelText,
    this.hintText,
    this.onSaved,
    this.validator,
    this.controller,
    this.focusNode,
    this.onFieldSubmitted,
    this.maxLine,
    this.keyboardType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 10, bottom: 2),
          child: Text(
            labelText,
            style: TextStyle(
              color: Colors.black45,
            ),
          ),
        ),
        TextFormField(
          onSaved: onSaved,
          validator: validator,
          controller: controller,
          focusNode: focusNode,
          maxLines: maxLine ?? 1,
          keyboardType: keyboardType,
          onFieldSubmitted: onFieldSubmitted,
          cursorColor: orangePrimaryColor,
          decoration: buildInputDecoration(),
        ),
      ],
    );
  }

  InputDecoration buildInputDecoration() {
    return InputDecoration(
      hintText: hintText ?? '',
      contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      enabledBorder: buildOutlineInputBorder(),
      focusedBorder: buildOutlineInputBorder(),
    );
  }

  OutlineInputBorder buildOutlineInputBorder({bool isFocus}) =>
      OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        borderSide: BorderSide(color: orangePrimaryColor),
      );
}
