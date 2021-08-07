import 'package:flutter/material.dart';
import 'package:project_app/ui/screens/test/components/tree_directory/tree_directory.dart';
import 'package:project_app/ui/screens/test/components/url_launch.dart';

import 'body.dart';

class TextScreen extends StatelessWidget {
  const TextScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Text Screen')),
      // body: Container(),
      // body: TreeDirectory(),
      // body: Body(),
      body: Launch(),
    );
  }
}
