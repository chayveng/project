import 'package:flutter/material.dart';

import 'body.dart';

class TextScreen extends StatelessWidget {
  const TextScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Text Screen')),
      body: Body(),
    );
  }
}
