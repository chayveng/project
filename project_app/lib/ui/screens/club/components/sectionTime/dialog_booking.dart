import 'package:flutter/material.dart';

class DialogBooking extends StatelessWidget {
  final VoidCallback onBooking;

  const DialogBooking({
    Key key,
    @required this.onBooking,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        height: 100,
        child: RaisedButton(
          child: Text('book'),
          onPressed: onBooking,
        ),
      ),
    );
  }
}
