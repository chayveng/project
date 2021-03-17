import 'dart:ui';

import 'package:flutter/material.dart';

import '../../../../constants.dart';

class CardField extends StatelessWidget {
  final String fieldName;
  final GestureTapCallback onTap;

  const CardField({
    Key key,
    this.fieldName,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size sized = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.only(left: 10,right: 10, top: 10),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Material(
          color: creamPrimaryColor,
          child: InkWell(
            onTap: onTap,
            child: Container(
              height: 50,
              child: Center(
                child: Text(
                  fieldName,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}