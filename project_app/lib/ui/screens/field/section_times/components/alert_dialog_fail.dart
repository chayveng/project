import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_app/constants.dart';

class AlertDialogFail extends StatelessWidget {
  const AlertDialogFail({Key? key}) : super(key: key);

  Widget footer(BuildContext context) => InkWell(
        onTap: () {
          Navigator.pop(context,true);
        },
        child: Expanded(
          child: Container(
            height: 45,
            decoration: BoxDecoration(
              color: orangeColor.withOpacity(0.1),
              border: Border(
                top: BorderSide(width: 1, color: orangeColor),
              ),
            ),
            child: Center(
              child: Text('ตกลง',style: TextStyle(fontSize: 16),),
            ),
          ),
        ),
      );

  Widget content() => Column(
        children: [
          Icon(Icons.event_busy,size: 40,color: Colors.redAccent,),
          Text(
            'ช่วงเวลาไม่ถูกต้อง หรืออาจถูกจองแล้ว',
            style: TextStyle(fontSize: 16),
          ),
        ],
      );

  Widget title() => Text(
        'จองล้มเหลว',
        style: TextStyle(fontSize: 20, color: orangeColor),
      );

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          title(),
          content(),
          SizedBox(height: 15),
          footer(context),
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
