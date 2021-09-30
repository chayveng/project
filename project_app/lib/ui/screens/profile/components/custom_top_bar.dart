import 'package:flutter/material.dart';

import '../../../../constants.dart';

class CustomAppBar extends StatelessWidget {
  final bool? status;
  final GestureTapCallback? onEdit;

  const CustomAppBar({
    Key? key,
    @required this.status,
    @required this.onEdit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
<<<<<<< HEAD
      title: Text('ข้อมูลส่วนตัว'),
=======
      title: Text('profile'),
>>>>>>> master
      actions: [edit()],
    );
  }

  Widget edit() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: GestureDetector(
        onTap: onEdit,
        child: Icon(
          status! ? Icons.edit : Icons.edit_off,
          color: navyPrimaryColor,
          size: 22,
        ),
      ),
    );
  }
}
