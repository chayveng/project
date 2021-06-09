import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  final bool? isOwner;
  final VoidCallback? onEdit;

  const CustomAppBar({Key? key, this.onEdit, this.isOwner}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text('Field'),
      actions: [
       isOwner! ? IconButton(
          icon: Icon(Icons.edit),
          onPressed: onEdit,
        ): SizedBox(),
      ],
    );
  }
}
