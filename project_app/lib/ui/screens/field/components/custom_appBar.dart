import 'package:flutter/material.dart';
import 'package:project_app/ui/screens/main/main_screen.dart';

class CustomAppBar extends StatelessWidget {
  final bool? isOwner;
  final VoidCallback? onEdit;
  final String? title;

  const CustomAppBar({Key? key, this.onEdit, this.isOwner, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: () {
          isOwner!
              ? Navigator.pop(context)
              : Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MainScreen(
                      currentIndex: 0,
                    ),
                  ),
                  (route) => false);
          print('back');
        },
      ),
      title: Text(title!),
      actions: [
        isOwner!
            ? IconButton(
                icon: Icon(Icons.edit),
                onPressed: onEdit,
              )
            : SizedBox(),
      ],
    );
  }
}
