import 'package:flutter/material.dart';

class TimesDialog extends StatefulWidget {
  @override
  _MyDialogState createState() => _MyDialogState();
}

class _MyDialogState extends State<TimesDialog> {
  bool isValue1 = false;
  bool isValue2 = false;
  bool isValue3 = false;

  @override
  Widget build(BuildContext context) {
    Size sized = MediaQuery.of(context).size;
    return Dialog(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 15),
        width: sized.width,
        color: Colors.white30,
        child: SingleChildScrollView(
          child: buildListSection(context),
        ),
      ),
    );
  }

  Column buildListSection(BuildContext context) {
    return Column(
      children: [
        Text(
          'Title',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        TimeList(),
        buildRowButton(context),
      ],
    );
  }

  Row buildRowButton(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        TextButton(
            onPressed: () {
              print('Add');
            },
            child: Text('Add')),
        TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('Cancel')),
        TextButton(
            onPressed: () {
              print('Ok');
            },
            child: Text('Ok')),
      ],
    );
  }
}

class TimeList extends StatelessWidget {
  const TimeList({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Checkbox(
          value: true,
          onChanged: (value) {
          },
        ),
        Expanded(child: Text('12:00 - 13:00')),
        IconButton(icon: Icon(Icons.edit), onPressed: (){}),
        IconButton(icon: Icon(Icons.close), onPressed: (){}),
      ],
    );
  }
}
