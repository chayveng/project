import 'package:flutter/material.dart';

import '../../../../../constants.dart';

class DialogBooking extends StatelessWidget {
  final VoidCallback onBooking;

  const DialogBooking({
    Key key,
    @required this.onBooking,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Booking time'),
      content: Text('Confirm booking time.'),
      actions: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Text(
              'Cancel',
              style: TextStyle(color: orangePrimaryColor),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: InkWell(
            onTap: onBooking,
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
