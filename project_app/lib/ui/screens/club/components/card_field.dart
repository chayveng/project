import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:project_app/core/models/Field.dart';

import '../../../../constants.dart';

class CardField extends StatelessWidget {
  final Field field;
  final GestureTapCallback onTap;

  const CardField({
    Key key,
    this.field,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: GestureDetector(
        onTap: () {
          print('field');
        },
        child: Container(
          padding: EdgeInsets.all(8),
          width: sized(context).width,
          color: creamPrimaryColor,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                field.title,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 5),
              Text(field.detail),
              Text(field.price),
            ],
          ),
        ),
      ),
    );
  }
}
