// import 'package:flutter/material.dart';
// import 'package:project_app/constants.dart';
// import 'package:project_app/core/models/Club.dart';
// import 'package:project_app/core/services/AuthService.dart';
// import 'package:project_app/core/services/ClubService.dart';
// import 'package:project_app/ui/screens/club/club_screen.dart';
//
// import 'not_created.dart';
//
// class Body extends StatefulWidget {
//   @override
//   _BodyState createState() => _BodyState();
// }
//
// class _BodyState extends State<Body> {
//   Club club = Club();
//   bool _status = false;
//
//   @override
//   void initState() {
//     isCreate();
//     // Future.delayed(Duration(milliseconds: 200), () => setState(() {}));
//     super.initState();
//   }
//
//   Future<void> isCreate() async {
//     var userId = await AuthService.getUserId();
//     club = await ClubService.getByUserId(userId: userId);
//     if (club.userId == null) {
//       club.userId = userId;
//       _status = !_status;
//     } else {
//       Navigator.push(
//         context,
//         MaterialPageRoute(
//           builder: (context) => ClubScreen(club: club),
//         ),
//       );
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     // buildDialogLoading(context, 1500);
//     return _status == false ? NotCreated() : ClubScreen(club: club);
//     // return Column(
//     //   children: [
//     //     RaisedButton(
//     //       onPressed: () {
//     //         Navigator.push(
//     //           context,
//     //           MaterialPageRoute(
//     //             builder: (context) => ClubScreen(club: club),
//     //           ),
//     //         );
//     //       },
//     //     ),
//     //   ],
//     // );
//   }
// }
