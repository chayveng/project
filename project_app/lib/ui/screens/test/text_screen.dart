import 'package:flutter/material.dart';
import 'package:project_app/ui/screens/test/components/tree_directory/tree_directory.dart';

import 'body.dart';

class TextScreen extends StatelessWidget {
  const TextScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black38,
      appBar: AppBar(title: Text('Text Screen')),
      body: TreeDirectory(),
      // body: Body(),
    );
  }
}
