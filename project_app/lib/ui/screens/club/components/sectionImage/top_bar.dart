import 'package:flutter/material.dart';
import 'package:project_app/ui/screens/main/main_screen.dart';

import '../../../../../constants.dart';

class TopBar extends StatelessWidget {
  final String title;
  final bool isOwner;
  final VoidCallback editTap;

  const TopBar({
    Key key,
    this.title,
    this.isOwner,
    this.editTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: sized(context).width,
      decoration: BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment(0, -1),
            end: Alignment(0, 1),
            colors: [Colors.black, Colors.transparent],
            stops: [0, 1]),
      ),
      child: Column(
        children: [
          SafeArea(child: SizedBox()),
          ListTile(
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
              ),
              onPressed: () {
                // (isOwner)
                //     ? Navigator.pushAndRemoveUntil(
                //         context,
                //         MaterialPageRoute(
                //           builder: (context) => MainScreen(
                //             currentIndex: 2,
                //           ),
                //         ),
                //         (route) => false)
                //     : Navigator.pop(context);
              },
            ),
            title: Text(
              title,
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            trailing: isOwner == true
                ? IconButton(
                    icon: Icon(
                      Icons.edit,
                      color: Colors.white,
                    ),
                    onPressed: editTap,
                  )
                : SizedBox(),
          ),
          SizedBox(height: 30),
        ],
      ),
    );
  }
}
