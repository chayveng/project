import 'package:flutter/material.dart';
import 'package:project_app/ui/components/rounded_button.dart';
import '../../../constants.dart';

import 'body.dart';

class GoogleMapScreen extends StatelessWidget {
  static String routeName = '/test_screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            width: sized(context).width * 0.8,
            height: 80,
            child: RoundedButton(
              text: 'Map',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Body(),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

