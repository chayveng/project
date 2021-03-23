import 'dart:ui';

import 'package:flutter/material.dart';

import '../../../../constants.dart';

class CardField extends StatelessWidget {
  final String fieldName;
  final GestureTapCallback onTap;
  final String title;
  final String price;
  final String time;

  const CardField({
    Key key,
    this.fieldName,
    @required this.onTap,
    @required this.title,
    @required this.price,
    @required this.time,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size sized = MediaQuery.of(context).size;
    // return Padding(
    //   padding: const EdgeInsets.only(left: 10,right: 10, top: 10),
    //   child: ClipRRect(
    //     borderRadius: BorderRadius.circular(10),
    //     child: Material(
    //       color: creamPrimaryColor,
    //       child: InkWell(
    //         onTap: onTap,
    //         child: Container(
    //           height: 50,
    //           child: Center(
    //             child: Text(
    //               fieldName,
    //               style: TextStyle(
    //                 fontSize: 16,
    //                 fontWeight: FontWeight.bold,
    //               ),
    //             ),
    //           ),
    //         ),
    //       ),
    //     ),
    //   ),
    // );
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Material(
        color: creamPrimaryColor,
        child: InkWell(
          onTap: onTap,
          child: Container(
            padding: EdgeInsets.all(10),
            width: sized.width,
            // color: creamPrimaryColor,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 20,
                    color: orangePrimaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  price,
                  style: TextStyle(
                    fontSize: 14,
                    color: greenPrimaryColor,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  time,
                  style: TextStyle(
                    fontSize: 14,
                    color: greenPrimaryColor,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
