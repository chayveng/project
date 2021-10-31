import 'package:flutter/material.dart';

import '../../../../constants.dart';

class CardMenu extends StatelessWidget {
  final bool? status;
  final String? title;
  final String? hintText;
  final FormFieldSetter? onSaved;
  final ValueChanged<String>? onChanged;
  final FormFieldValidator? validator;
  final FocusNode? focusNode;
  final ValueChanged? onFieldSubmitted;
  final TextInputType? keyboardType;

  const CardMenu({
    Key? key,
    @required this.status,
    @required this.title,
    this.onSaved,
    this.validator,
    this.hintText,
    this.focusNode,
    this.onFieldSubmitted,
    this.keyboardType,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: customField(),
    );
  }

  TextFormField customField() {
    return TextFormField(
      onSaved: onSaved,
      onChanged: onChanged,
      validator: validator,
      controller: TextEditingController(text: title ?? ''),
      style: TextStyle(fontSize: 14),
      enabled: status,
      focusNode: focusNode,
      onFieldSubmitted: onFieldSubmitted,
      keyboardType: keyboardType,
      decoration: inputDecoration(),
    );
  }

  InputDecoration inputDecoration() {
    return InputDecoration(
      hintText: hintText,
      isDense: true,
      contentPadding: EdgeInsets.symmetric(horizontal: 0, vertical: 14),
      hintStyle: TextStyle(fontSize: 14, color: Colors.black38),
      disabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(width: 1, color: orangePrimaryColor)),
    focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(width: 1, color: orangePrimaryColor)),
    );
  }
}
