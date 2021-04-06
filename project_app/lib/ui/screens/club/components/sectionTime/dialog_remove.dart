import 'package:flutter/material.dart';

import '../../../../../constants.dart';

class DialogRemove extends StatelessWidget {
  final int fieldId;
  final int timeId;
  final VoidCallback isOk;

  const DialogRemove({
    Key key,
    @required this.isOk,
    this.fieldId,
    this.timeId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Remove time'),
      content: Text('Confirm remove time.'),
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
            onTap: isOk,
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
