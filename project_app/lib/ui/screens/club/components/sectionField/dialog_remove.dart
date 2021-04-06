import 'package:flutter/material.dart';
import 'package:project_app/core/services/FieldServices.dart';

import '../../../../../constants.dart';

class DialogRemove extends StatelessWidget {
  final VoidCallback onPressed;

  const DialogRemove({
    Key key,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Remove field'),
      content: Text('Confirm remove'),
      actions: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: InkWell(
            onTap: () {Navigator.pop(context);},
            child: Text(
              'Cancel',
              style: TextStyle(color: orangePrimaryColor),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: InkWell(
            onTap: onPressed,
            child: Text(
              'Ok',
              style: TextStyle(color: orangePrimaryColor),
            ),
          ),
        ),
      ],
    );
  }
}
