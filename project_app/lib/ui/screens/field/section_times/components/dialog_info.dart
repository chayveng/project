import 'package:flutter/material.dart';

class DialogInfo extends StatefulWidget {

  final int? userId;
  const DialogInfo({Key? key, this.userId}) : super(key: key);

  @override
  _DialogInfoState createState() => _DialogInfoState();
}

class _DialogInfoState extends State<DialogInfo> {

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Center(
        child: Text(
          'ผู้จอง',
        ),
      ),
      content: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text('userName'),
          Text('32423445678'),
        ],
      ),
    );
  }
}
