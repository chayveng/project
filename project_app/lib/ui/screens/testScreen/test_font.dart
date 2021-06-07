import 'package:flutter/material.dart';

class TestFont extends StatelessWidget {
  const TestFont({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'สวัสดี ',
            style: TextStyle(
                fontSize: 50, fontFamily: 'Kanit', fontWeight: FontWeight.bold),
          ),
          Text(
            'สวัสดี',
            style: TextStyle(fontSize: 50, fontFamily: 'Kanit'),
          ),
          Text(
            'สวัสดี',
            style: TextStyle(
              fontSize: 50,
            ),
          ),
          Text(
            'สวัสดี',
            style: TextStyle(
              fontSize: 50,
            ),
          ),
        ],
      ),
    );
  }
}
