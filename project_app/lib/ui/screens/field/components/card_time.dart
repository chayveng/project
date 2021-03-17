import 'package:flutter/material.dart';

import '../../../../constants.dart';

class CardTime extends StatelessWidget {
  final VoidCallback onPressed;
  final String time;
  final bool status;

  const CardTime({
    Key key,
    @required this.time,
    this.onPressed,
    this.status,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size sized = MediaQuery.of(context).size;
    return Container(
      height: 50,
      width: sized.width,
      margin: EdgeInsets.only(top: 10, left: 8.0, right: 8.0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15), color: creamPrimaryColor),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Text(
                time,
                style: TextStyle(
                  fontSize: 20,
                  color: navyPrimaryColor,
                ),
              ),
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: RaisedButton(
                color: (status == false) ? Colors.lightGreenAccent : Colors.red,
                child: Text('Ready'),
                onPressed: (status == false) ? onPressed : null,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
