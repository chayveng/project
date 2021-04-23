import 'package:flutter/material.dart';

import '../../../../constants.dart';

class CardMenu extends StatelessWidget {
  final bool status;
  final String title;
  final String hintText;
  final FormFieldSetter onSaved;
  final FormFieldValidator validator;

  const CardMenu({
    Key key,
    @required this.status,
    @required this.title,
    this.onSaved,
    this.validator,
    this.hintText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45,
      width: sized(context).width,
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(width: 1, color: orangePrimaryColor)),
      ),
      child: Align(
        alignment: Alignment.centerLeft,
        child: formField(),
      ),
    );
  }

  Widget formField() {
    return status
        ? TextFormField(
            onSaved: onSaved,
            validator: validator,
            controller: TextEditingController(text: title ?? ''),
            style: TextStyle(fontSize: 14),
            decoration: InputDecoration(
              isDense: true,
              contentPadding: EdgeInsets.symmetric(horizontal: 0, vertical: 14),
              hintText: hintText,
              hintStyle: TextStyle(fontSize: 14),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(width: 0.5, color: orangePrimaryColor),
              ),
            ),
          )
        : title == null
            ? Text(
                hintText,
                style: TextStyle(color: Colors.black.withOpacity(0.5)),
              )
            : Text(title);
  }
}
