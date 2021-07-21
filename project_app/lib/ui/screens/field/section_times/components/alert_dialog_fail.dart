import 'package:flutter/material.dart';
import 'package:project_app/constants.dart';

class AlertDialogFail extends StatelessWidget {
  const AlertDialogFail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('!!! เวลาไม่ถูกต้อง หรือช่วงเวลานี้ถูกจองแล้ว',style: TextStyle(fontSize: 18),),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(
                'ตกลง',
                style: TextStyle(color: orangeColor),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
