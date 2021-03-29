import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter/material.dart';
import 'package:project_app/constants.dart';

class CustomDialogLoading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      child: SpinKitWave(
        color: orangePrimaryColor,
        size: 40,
      ),
    );
  }
}
