import 'package:flutter/material.dart';
import 'package:project_app/ui/components/rounded_button.dart';

import '../../../constants.dart';

class TestScreen extends StatefulWidget {
  static String routeName = '/test_screen';

  @override
  _TestScreenState createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  @override
  Widget build(BuildContext context) {
    Size sized = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text('TestScreen'),
      ),
      body: Center(
        child: Container(
          width: 300,
          height: 100,
          child: RoundedButton(
            onTap: () {
              // _showMyDialog(context);
              print('ok');
              showDialog(
                  context: context,
                  // barrierDismissible: false,
                  builder: (BuildContext context) => MyDialog());
            },
            text: 'go',
          ),
        ),
      ),
    );
  }

  Future<void> _showMyDialog(context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('AlertDialog Title'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('This is a demo alert dialog.'),
                Text('This is a demo alert dialog.'),
                Text('This is a demo alert dialog.'),
                Text('This is a demo alert dialog.'),
                Text('This is a demo alert dialog.'),
                Text('This is a demo alert dialog.'),
                Text('This is a demo alert dialog.'),
                Text('This is a demo alert dialog.'),
                Text('This is a demo alert dialog.'),
                Text('This is a demo alert dialog.'),
                Text('This is a demo alert dialog.'),
              ],
            ),
          ),
          actions: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  child: Text('Cancel'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                TextButton(
                  child: Text('Ok'),
                  onPressed: () {},
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}

class MyDialog extends StatefulWidget {
  @override
  _MyDialogState createState() => _MyDialogState();
}

class _MyDialogState extends State<MyDialog> {
  bool isValue = false;

  @override
  Widget build(BuildContext context) {
    Size sized = MediaQuery.of(context).size;
    return Dialog(
      child: Container(
        width: sized.width,
        height: sized.height * 0.8,
        color: Colors.white30,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                children: [
                  Checkbox(
                    value: isValue,
                    onChanged: (value) {
                      setState(() {
                        isValue = !isValue;
                      });
                    },
                  ),
                  Text('I am true now'),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
