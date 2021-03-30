import 'package:flutter/material.dart';
import 'package:project_app/core/models/Club.dart';
import 'package:project_app/ui/components/rounded_button.dart';
import 'package:project_app/ui/screens/createClub/create_club.dart';

import '../../../../constants.dart';

class NotCreated extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: creamPrimaryColor,
      appBar: AppBar(
        brightness: Brightness.light,
        elevation: 0,
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(color: blackPrimaryColor.withOpacity(0.5)),
      ),
      body: Container(
        width: sized(context).width,
        height: sized(context).height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Don\'t have your club',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 10),
            Container(
              width: sized(context).width * 0.5,
              child: RoundedButton(
                text: 'Create',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CreateClub(
                        isOwner: true,
                        club: Club(),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
