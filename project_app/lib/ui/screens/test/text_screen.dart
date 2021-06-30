import 'package:flutter/material.dart';
import 'package:project_app/ui/screens/test/components/url_luncher/luncher.dart';

import 'body.dart';

class TextScreen extends StatelessWidget {
  const TextScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Text Screen')),
      body: LaunchUrl(),
      // body: Body(),
    );
  }
}
