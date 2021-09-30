import 'package:flutter/material.dart';

import '../../../../constants.dart';

class DialogLogout extends StatelessWidget {
  final VoidCallback? itOk;

  const DialogLogout({
    Key? key,
    this.itOk,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('คุณต้องการออกจากระบบ ?'),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text('ยกเลิก',style: TextStyle(color: orangeColor),),
        ),
        TextButton(
          onPressed: itOk,
          child: Text('ยืนยัน',style: TextStyle(color: orangeColor),),
        ),
      ],
    );
  }
}
