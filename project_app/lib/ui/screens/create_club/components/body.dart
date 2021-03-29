import 'package:flutter/material.dart';
import 'package:project_app/core/models/Club.dart';

import 'from_create.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  Club _club = Club();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: Column(
          children: [
            FromCreate(),
          ],
        ),
      ),
    );
  }

}
