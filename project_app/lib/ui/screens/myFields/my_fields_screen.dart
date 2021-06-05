import 'package:flutter/material.dart';
import 'package:project_app/ui/screens/field/create/create_field_screen.dart';

import '../../../constants.dart';
import 'body.dart';

// class MyFieldsScreen extends StatefulWidget {
//   const MyFieldsScreen({Key key}) : super(key: key);
//
//   @override
//   _MyFieldsScreenState createState() => _MyFieldsScreenState();
// }
//
// class _MyFieldsScreenState extends State<MyFieldsScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Body(),
//     );
//   }
// }

class MyFieldsScreen extends StatelessWidget {
  const MyFieldsScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: greyPrimaryColor,
      body: Body(),
    );
  }
}

