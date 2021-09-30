import 'package:flutter/material.dart';

class CustomAppbar extends StatelessWidget {
  final VoidCallback? onPressed;

  const CustomAppbar({Key? key, this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      excludeHeaderSemantics: false,
      primary: true,
<<<<<<< HEAD
      title: Text('สนามของฉัน'),
=======
      title: Text('My Fields'),
>>>>>>> master
      actions: [
        IconButton(
          icon: Icon(Icons.add),
          onPressed: onPressed,
        ),
      ],
    );
  }
}
