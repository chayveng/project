import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../../constants.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: sized(context).width,
      child: SingleChildScrollView(
        child: Column(
          children: [
            testButton(
              onPressed: () async{
                print('');
              },
            ),
          ],
        ),
      ),
    );
  }
}
