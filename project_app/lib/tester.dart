import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:project_app/constants.dart';

class TesterScreen extends StatefulWidget {
  const TesterScreen({Key? key}) : super(key: key);

  @override
  _TesterScreenState createState() => _TesterScreenState();
}

class _TesterScreenState extends State<TesterScreen> {
  List<Widget> itemWidget = [];

  _onButton() {
    var item = {
      "A": 1.10,
      "B": 2.20,
      "C": 3.30,
      "D": 4.40,
      "E": 5.50,
    };
    itemWidget.clear();
    item.forEach((key, value) => itemWidget.add(formItem(key, value)));
    setState(() {});
  }

  Widget formItem(var key, var value) {
    return ListTile(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text('$key', style: TextStyle(fontSize: 22)),
          Text('$value', style: TextStyle(fontSize: 22)),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: sized(context).width,
        height: sized(context).height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 55,
              height: 100,
              color: Colors.amber,
              // child: Text("sdfsdfsd"),
            ),
            ElevatedButton(onPressed: () => _onButton(), child: Text('button')),
            ...List.generate(itemWidget.length, (index) => itemWidget[index]),
          ],
        ),
      ),
    );
  }
}
