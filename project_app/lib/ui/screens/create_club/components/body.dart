import 'package:flutter/material.dart';
import 'package:project_app/constants.dart';
import 'package:project_app/ui/screens/create_club/components/form_create.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      margin: EdgeInsets.all(10),
      height: sized(context).height,
      width: sized(context).width,
      decoration: BoxDecoration(
        color: creamPrimaryColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: SingleChildScrollView(
        child: FormCreateClub(),
      ),
    );
  }
}
