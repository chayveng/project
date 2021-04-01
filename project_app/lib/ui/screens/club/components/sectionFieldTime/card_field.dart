import 'package:flutter/material.dart';
import 'package:project_app/core/models/Field.dart';

import '../../../../../constants.dart';

class CardField extends StatelessWidget {
  final Field field;

  const CardField({
    Key key,
    @required this.field,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: sized(context).width,
      color: Colors.redAccent,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(field.title),
          Text(field.detail),
          Text(field.price),
        ],
      ),
    );
  }
}
