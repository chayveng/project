import 'package:flutter/material.dart';
import 'package:project_app/core/models/Field.dart';

import '../../../constants.dart';
import 'components/body.dart';

class FieldScreen extends StatelessWidget {
  static String routeName = '/field';

  final Field field;

  const FieldScreen({
    Key key,
    this.field,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: Body(field: field),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      // elevation: 0,
      iconTheme: IconThemeData(color: greenPrimaryColor),
      title: Text(
        field.fieldName,
        style: TextStyle(
          color: greenPrimaryColor,
          fontWeight: FontWeight.bold,
        ),
      ),
      backgroundColor: creamPrimaryColor,
    );
  }
}
