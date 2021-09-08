import 'package:flutter/material.dart';
import 'package:project_app/ui/screens/test/components/tree_directory/tree_directory.dart';
import 'package:project_app/ui/screens/test/components/url_launcher/url_launcher.dart';

import 'body.dart';

class TestScreen extends StatelessWidget {
  const TestScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(title: Text('Text Screen')),
      body: Body(),
      // body: UrlLauncher(),
      // body: Container(),
      // body: TreeDirectory(),
    );
  }
}
