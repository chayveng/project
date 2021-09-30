import 'package:flutter/material.dart';

<<<<<<< HEAD
import '../../../../constants.dart';

=======
>>>>>>> master
class DialogLogout extends StatelessWidget {
  final VoidCallback? itOk;

  const DialogLogout({
    Key? key,
    this.itOk,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
<<<<<<< HEAD
      title: Text('คุณต้องการออกจากระบบ ?'),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text('ยกเลิก',style: TextStyle(color: orangeColor),),
        ),
        TextButton(
          onPressed: itOk,
          child: Text('ยืนยัน',style: TextStyle(color: orangeColor),),
=======
      title: Text('Logout'),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text("Cancel"),
        ),
        TextButton(
          onPressed: itOk,
          child: Text("Ok"),
>>>>>>> master
        ),
      ],
    );
  }
}
