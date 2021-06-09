import 'package:flutter/material.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'ยังไม่มีการจองสนาม',
        style: TextStyle(
            fontSize: 15,  fontFamily: 'Kanit'),
      ),
    );
  }
}
