import 'package:flutter/material.dart';
import 'package:project_app/constants.dart';

import 'body.dart';

class TestScreen extends StatelessWidget {
  static String routeName = '/test_screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   elevation: 0,
      //   title: Text(
      //     'TestScreen',
      //   ),
      // ),

      // body: FeedJsonData(),
      // body: CustomTimePicker(),
      // body: CustomAppBarListViewButton(),
      // body: TimeListSection(),
      body: Body(),
    );
  }
}

// class Body extends StatefulWidget {
//   @override
//   _BodyState createState() => _BodyState();
// }
//
// class _BodyState extends State<Body> {
//   bool status = false;
//   double _height = 0;
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.only(top: 50),
//       child: Container(
//         width: sized(context).width,
//         child: Column(
//           children: [
//             GestureDetector(
//               onTap: () {
//                 setState(() {
//                   status = !status;
//                   status == true ? _height = 200 : _height = 0;
//                 });
//               },
//               child: Container(
//                 color: Colors.red,
//                 height: 60,
//                 width: sized(context).width * 0.9,
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text("data"),
//                     Text("data"),
//                     Text("data"),
//                   ],
//                 ),
//               ),
//             ),
//             AnimatedContainer(
//               color: Colors.yellow,
//               height: _height,
//               width: sized(context).width * 0.9,
//               duration: Duration(milliseconds: 20),
//               child: status == true ? buildColumn() : SizedBox(),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   SingleChildScrollView buildColumn() {
//     return SingleChildScrollView(
//       child: Column(
//         children: [
//           Text("data"),
//           Text("data"),
//           Text("data"),
//           Text("data"),
//           Text("data"),
//           Text("data"),
//           Text("data"),
//           Text("data"),
//           Text("data"),
//           Text("data"),
//         ],
//       ),
//     );
//   }
// }
