import 'package:flutter/material.dart';

class NotBooking extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 200,
            height: 200,
            child: Image.asset('assets/images/non_booking.png'),
          ),
          SizedBox(height: 20),
<<<<<<< HEAD
          Text('ไม่มีการจองสนาม',style: TextStyle(fontSize: 18),),
=======
          Text('Not booking'),
>>>>>>> master
        ],
      ),
    );
  }
}