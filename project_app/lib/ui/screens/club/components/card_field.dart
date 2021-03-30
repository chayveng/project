import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:project_app/core/models/Field.dart';

import '../../../../constants.dart';

class CardField extends StatelessWidget {
  final Field field;
  final GestureTapCallback onTap;
  final bool isOwner;

  const CardField({
    Key key,
    @required this.field,
    @required this.onTap,
    this.isOwner = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Material(
        color: creamPrimaryColor,
        child: InkWell(
          onTap: onTap,
          child: Container(
            padding: EdgeInsets.all(8),
            width: sized(context).width,
            child: StreamBuilder<Object>(
                stream: null,
                builder: (context, snapshot) {
                  return Column(
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
                  );
                }),
          ),
        ),
      ),
    );
  }
}
