import 'package:flutter/material.dart';
import 'package:project_app/ui/screens/test/custom_dialog_datetime_picker.dart';

import 'body.dart';

class TextScreen extends StatelessWidget {
  const TextScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Text Screen'),
        actions: [
          ElevatedButton(
            onPressed: () {
              showDialog(context: context, builder: (context) => CustomDialogDatetimePicker());
            },
            child: Text(''),
          ),
        ],
      ),
      body: Body(),
    );
  }
}
