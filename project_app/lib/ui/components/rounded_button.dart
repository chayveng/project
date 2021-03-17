import 'package:flutter/material.dart';

import '../../constants.dart';


class RoundedButton extends StatelessWidget {
  final String text;
  final GestureTapCallback onTap;
  final FocusNode focusNode;
  final bool autofocus;

  const RoundedButton({
    Key key,
    @required this.text,
    @required this.onTap,
    this.focusNode,
    this.autofocus = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color color = Colors.black54;
    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(10.0),),
      child: Material(
        color: orangePrimaryColor,
        child: InkWell(
          focusNode: focusNode,
          onTap: onTap,
          autofocus: autofocus,
          highlightColor: Colors.redAccent,
          child: Container(
            padding: EdgeInsets.only(top: 15, bottom: 15),
            child: Center(
              child: Text(
                text,
                style: TextStyle(
                  color: greenPrimaryColor,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
