import 'package:flutter/material.dart';

class FieldTime extends StatelessWidget {
  final FormFieldSetter onSaved;
  final FormFieldValidator validator;

  const FieldTime({
    Key key,
    @required this.onSaved,
    @required this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double size = 80;
    return Container(
      width: size,
      height: size,
      child: Center(
        child: TextFormField(
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 40),
          maxLength: 2,
          keyboardType: TextInputType.phone,
          autofocus: true,
          onSaved: onSaved,
          validator: validator,
          decoration: InputDecoration(
            hintText: '00',
            filled: true,
            fillColor: Colors.yellow,
            counterText: '',
            enabledBorder: buildUnderlineInputBorder(),
            focusedBorder: buildUnderlineInputBorder(),
            errorBorder: buildUnderlineInputBorder(),
            focusedErrorBorder: buildUnderlineInputBorder(),
          ),
        ),
      ),
    );
  }

  UnderlineInputBorder buildUnderlineInputBorder() {
    return UnderlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(10)),
      borderSide: BorderSide.none,
    );
  }
}
