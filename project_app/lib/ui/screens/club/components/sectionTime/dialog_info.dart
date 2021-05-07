import 'package:flutter/material.dart';
import 'package:project_app/constants.dart';
import 'package:project_app/core/models/Time.dart';
import 'package:project_app/core/models/User.dart';

class DialogInfo extends StatelessWidget {
  final Time time;
  final User user;

  const DialogInfo({Key key, this.time, this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        height: sized(context).height * 0.2,
        child: Column(
          children: [
            ListTile(
              title: Text('Time Info'),
            ),
            Text('Booking By: ${user.userName ?? '-'}'),
            SizedBox(height: 8),
            Text('Tel: ${user.tel ?? '-'}'),
          ],
        ),
      ),
    );
    // return AlertDialog(
    //   title: Text('Time Info'),
    //   content: Text(user.userName + '\n' + user.tel),
    // );
  }
}
