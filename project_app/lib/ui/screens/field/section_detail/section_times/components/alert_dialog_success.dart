import 'package:flutter/material.dart';

import '../../../../../../constants.dart';

class DialogSuccess extends StatelessWidget {
  const DialogSuccess({Key? key}) : super(key: key);

  Widget footer(BuildContext context) => InkWell(
    onTap: () {
      Navigator.pop(context);
    },
    child: Container(
      width: sized(context).width * 0.7,
      height: sized(context).height * 0.04,
      decoration: BoxDecoration(
        color: orangeColor.withOpacity(0.1),
        border: Border(
          top: BorderSide(width: 1, color: orangeColor),
        ),
      ),
      child: Center(
        child: Text('ตกลง'),
      ),
    ),
  );

  Widget content() => Column(
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.alarm_on_outlined, color: Colors.green, size: 35),
          SizedBox(width: 20),
          Text(
            'จองสำเร็จ',
            style: TextStyle(fontSize: 16),
          ),
        ],
      ),
    ],
  );

  Widget title() => Text(
    '',
    style: TextStyle(fontSize: 20, color: orangeColor),
  );

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
<<<<<<< HEAD
          //     title(),
=======
>>>>>>> master
          SizedBox(height: 20),
          content(),
          SizedBox(height: 20),
          // footer(context),
        ],
      ),
    );
  }
}