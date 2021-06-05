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
      // appBar: AppBar(
      //   excludeHeaderSemantics: false,
      //   primary: true,
      //   title: Text('My Fields'),
      //   actions: [
      //     IconButton(
      //       icon: Icon(Icons.add),
      //       onPressed: () async {
      //         await Navigator.push(
      //               context,
      //               MaterialPageRoute(
      //                 builder: (context) => CreateFieldScreen(isCreate: true),
      //               ),
      //             ) ??
      //             fetchData();
      //       },
      //     ),
      //   ],
      // ),
      body: Body(),
    );
  }
}
