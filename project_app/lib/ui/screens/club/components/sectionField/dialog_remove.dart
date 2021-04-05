import 'package:flutter/material.dart';

import '../../../../../constants.dart';

class DialogRemove extends StatelessWidget {
  final VoidCallback onPressed;

  const DialogRemove({
    Key key,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        width: sized(context).width,
        height: 200,
        child: RaisedButton(
          child: Text('Confirm'),
          onPressed: onPressed,
          // onPressed: () async {
          //   print(fieldId);
          //   var res = await FieldServices.delete(id: fieldId);
          //   res ? print('deleted') : print('Fail');
          //   Navigator.pop(context);
          // },
        ),
      ),
    );
  }
}
