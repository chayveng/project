import 'package:flutter/material.dart';
import 'package:project_app/ui/screens/main/main_screen.dart';

import '../../../../../constants.dart';

class TopBar extends StatelessWidget {
  final String title;
  final bool isOwner;
  final VoidCallback onEdit;

  const TopBar({
    Key key,
    this.title,
    this.isOwner,
    this.onEdit,
  }) : super(key: key);

  _onBack({@required BuildContext context}) => isOwner
      ? Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => MainScreen(currentIndex: 2),
          ),
          (route) => false)
      : Navigator.pop(context);

  Widget buttonEdit() => isOwner == true
      ? IconButton(
          icon: Icon(Icons.edit, color: Colors.white),
          onPressed: onEdit,
        )
      : SizedBox();

  Widget textTitle() {
    return Text(
      title,
      style: TextStyle(
        color: Colors.white,
        fontSize: 16,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget buttonArrowBack({@required BuildContext context}) => IconButton(
        icon: Icon(Icons.arrow_back_ios, color: Colors.white),
        onPressed: () => _onBack(context: context),
      );

  @override
  Widget build(BuildContext context) {
    return Container(
      width: sized(context).width,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment(0, -1),
          end: Alignment(0, 1),
          colors: [Colors.black, Colors.transparent],
          stops: [0, 1],
        ),
      ),
      child: SafeArea(
        child: Column(
          children: [
            ListTile(
              leading: buttonArrowBack(context: context),
              title: textTitle(),
              trailing: buttonEdit(),
            ),
            SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
