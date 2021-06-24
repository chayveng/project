import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../constants.dart';

class CustomWidgetLoading extends StatelessWidget {
  const CustomWidgetLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: sized(context).width,
      height: sized(context).height,
      child: SpinKitWave(
        color: orangePrimaryColor,
        size: 40,
      ),
    );
  }
}
