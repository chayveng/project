import 'package:flutter/material.dart';
import 'package:project_app/core/models/Club.dart';
import 'package:project_app/core/models/Field.dart';
import 'package:project_app/ui/screens/club/components/card_field.dart';
import 'package:project_app/ui/screens/field/field_screen.dart';

import '../../../../constants.dart';

class Body extends StatelessWidget {
  final Club club;

  Body({Key key, this.club}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Field> fields = List.generate(
      3,
      (index) => new Field(
        id: index,
        clubId: club.id,
        fieldName: 'Field:$index',
      ),
    );
    Size sized = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            width: sized.width,
            height: 300,
            color: grayPrimaryColor,
            child: FlutterLogo(),
          ),
          ...List.generate(
            fields.length,
            (index) => CardField(
              fieldName: '${fields[index].fieldName}',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => FieldScreen(
                      field: fields[index],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
