import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  final String? title;
  final bool? isOwner;
  final VoidCallback? onEdit;

  const CustomAppBar({Key? key, this.onEdit, this.isOwner, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title ??'Field'),
      actions: [
       isOwner! ? IconButton(
          icon: Icon(Icons.edit),
          onPressed: onEdit,
        ): SizedBox(),
      ],
    );
  }
}
