import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AlertDialogFail extends StatelessWidget {
  const AlertDialogFail({Key? key}) : super(key: key);

  Widget footer() => Text('footer');

  Widget content() => Text('มีช่วง');

  Widget title() => Text('จองล้มเหลว');

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('kjdsklfjsldkjfksdjfjsl', ),
          title(),
          content(),
          footer(),
        ],
      ),
    );
    // return ClipRRect(
    //   borderRadius: BorderRadius.circular(20),
    //   child:AlertDialog(
    //     // child: Column(
    //     //   mainAxisSize: MainAxisSize.min,
    //     //   children: [
    //     //     Text('จองล้มเหลว'),
    //     //     Icon(Icons.close_rounded, color: Colors.redAccent, size: 145),
    //     //     Text('มีช่วงเวลานี้แล้ว'),
    //     //   ],
    //     // ),
    //     title: Text('จองล้มเหลว'),
    //     content: Column(
    //       mainAxisSize: MainAxisSize.min,
    //       children: [
    //         Icon(Icons.close_rounded, color: Colors.redAccent, size: 145),
    //         Text('มีช่วงเวลานี้แล้ว'),
    //       ],
    //     ),
    //   ),
    // );
  }
}
