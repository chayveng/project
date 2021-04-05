import 'package:flutter/material.dart';

import '../../../../../constants.dart';

class DialogConfirm extends StatelessWidget {
  final int fieldId;
  final int timeId;
  final VoidCallback isOk;

  const DialogConfirm({
    Key key,
    @required this.isOk,
    this.fieldId,
    this.timeId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        width: sized(context).width,
        height: 200,
        child: RaisedButton(
          child: Text('Confirm'),
          onPressed: isOk,
        ),
      ),
    );
  }
}
