import 'package:flutter/material.dart';

import '../../constants.dart';


class RoundedField extends StatelessWidget {
  final String label;
  final String hintText;
  final FormFieldSetter onSaved;
  final FormFieldValidator validator;
  final FocusNode focusNode;
  final ValueChanged onFieldSubmitted;
  final IconData prefixIcon;
  final Widget suffixIcon;
  final bool obscureText;

  const RoundedField({
    Key key,
    @required this.label,
    @required this.hintText,
    this.onSaved,
    this.validator,
    this.focusNode,
    this.onFieldSubmitted,
    this.prefixIcon,
    this.suffixIcon,
    this.obscureText = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          buildLabel(),
          SizedBox(height: 10),
          buildField(),
        ],
      ),
    );
  }

  TextFormField buildField() {
    return TextFormField(
      onSaved: onSaved,
      validator: validator,
      // cursorColor: Colors.pinkAccent,
      obscureText: obscureText,
      style: TextStyle(
        fontFamily: UiFont,
      ),
      decoration: InputDecoration(
        filled: true,
        fillColor: creamPrimaryColor,
        hintText: hintText,
        enabledBorder: buildUnderlineInputBorder(),
        focusedBorder: buildUnderlineInputBorder(),
        errorBorder: buildUnderlineInputBorder(),
        focusedErrorBorder: buildUnderlineInputBorder(),
        // contentPadding:
        //     EdgeInsets.only(left: 20, bottom: 10, top: 10, right: 20),
      ),
      focusNode: focusNode,
      onFieldSubmitted: onFieldSubmitted,
    );
  }

  UnderlineInputBorder buildUnderlineInputBorder() {
    return UnderlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(10)),
      borderSide: BorderSide.none,
    );
  }

  Row buildLabel() {
    return Row(
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            color: blackPrimaryColor,
            // color: Colors.black87,
            fontWeight: FontWeight.bold,
            // color: redPrimaryColor,
          ),
        )
      ],
    );
  }
}
