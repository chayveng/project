import 'package:flutter/material.dart';
import 'package:project_app/ui/components/rounded_button.dart';

import '../../../../constants.dart';

class NotCreated extends StatelessWidget {
  final GestureTapCallback onTap;

  const NotCreated({
    Key key,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                onTap: onTap,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
