import 'package:flutter/material.dart';

import '../../../../../../constants.dart';

class CardTimeSpinner extends StatelessWidget{
  final Widget? child;
  const CardTimeSpinner({Key? key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
        border: Border.all(width: 3, color: orangePrimaryColor),
        borderRadius: BorderRadius.circular(16),
      ),
      width: 50,
      height: 120,
      child: child,
    );
  }
}
