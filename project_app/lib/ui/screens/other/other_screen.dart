import 'package:flutter/material.dart';
import 'package:project_app/constants.dart';
import 'package:project_app/ui/components/custom_bottom_bar.dart';

import 'components/body.dart';

class OtherScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: grayPrimaryColor,
      appBar: AppBar(
        title: Text(
          'Other Screen',
        ),
      ),
      body: Body(),
    );
  }
}
