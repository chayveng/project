import 'package:flutter/material.dart';

class DialogLogout extends StatelessWidget {
  final VoidCallback itOk;

  const DialogLogout({
    Key key,
    this.itOk,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Logout'),
      actions: [
        FlatButton(
          onPressed: () => Navigator.pop(context),
          child: Text(
            "Cancel",
            style: TextStyle(color: Colors.orange),
          ),
        ),
        FlatButton(
          onPressed: itOk,
          child: Text(
            "Ok",
            style: TextStyle(color: Colors.orange),
          ),
        ),
      ],
    );
  }
}
