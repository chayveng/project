import 'package:flutter/material.dart';
import 'package:project_app/core/models/Field.dart';

import '../../../../../constants.dart';

class CardField extends StatelessWidget {
  final Field field;
  final bool isOwner;

  const CardField({
    Key key,
    @required this.field,
    this.isOwner = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      width: sized(context).width,
      decoration: BoxDecoration(
        border: Border.symmetric(
          horizontal: BorderSide(width: 1, color: grayPrimaryColor),
        ),
        color: creamPrimaryColor,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                field.title ?? '',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: orangePrimaryColor,
                ),
              ),
              SizedBox(height: 5),
              Text(field.detail ?? '', style: TextStyle(fontSize: 18)),
              SizedBox(height: 5),
              Text(field.price ?? '', style: TextStyle(fontSize: 18)),
            ],
          ),
          isOwner
              ? Row(
                children: [
                  IconButton(icon: Icon(Icons.edit), onPressed: (){print('Edit');}),
                  IconButton(
                      icon: Icon(Icons.remove_circle_outline_outlined),
                      onPressed: () {print('Delete');},
                    ),
                ],
              )
              : SizedBox(),
        ],
      ),
    );
  }
}
