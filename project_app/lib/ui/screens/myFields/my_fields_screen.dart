import 'package:flutter/material.dart';

import 'body.dart';

class MyFieldsScreen extends StatelessWidget {
  const MyFieldsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('MyFields'),
      //   actions: [
      //     IconButton(
      //       icon: Icon(Icons.add),
      //       onPressed: () {
      //         Navigator.push(
      //           context,
      //           MaterialPageRoute(
      //             builder: (context) => CreateFieldScreen(
      //               isCreate: true,
      //             ),
      //           ),
      //         );
      //       },
      //     ),
      //   ],
      // ),
      body: Body(),
    );
  }
}
