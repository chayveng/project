import 'package:flutter/material.dart';

class CustomAppbar extends StatelessWidget {

  final VoidCallback onPressed;


  const CustomAppbar({Key key, this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return         Align(
      alignment: Alignment.topCenter,
      child: Container(
        height: 100,
        child: AppBar(

          excludeHeaderSemantics: false,
          primary: true,
          title: Text('My Fields'),
          actions: [
            IconButton(
              icon: Icon(Icons.add),
              onPressed: onPressed,
              // onPressed: () async {
              //   await Navigator.push(
              //     context,
              //     MaterialPageRoute(
              //       builder: (context) =>
              //           CreateFieldScreen(isCreate: true),
              //     ),
              //   ) ??
              //       fetchData();
              // },
            ),
          ],
        ),
      ),
    );
  }
}
