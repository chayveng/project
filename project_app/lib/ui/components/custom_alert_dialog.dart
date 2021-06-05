import 'package:flutter/material.dart';

class CustomAlertDialog extends StatelessWidget {
  final bool showBtn;
  final String title;
  final String content;
  final String confirmBtn;
  final String cancelBtn;
  final VoidCallback onConfirm;
  final VoidCallback onCancel;

  const CustomAlertDialog({
    Key key,
    @required this.title,
    @required this.content,
    this.confirmBtn,
    this.cancelBtn,
    this.onConfirm,
    this.onCancel,
    this.showBtn = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: [
        showBtn ? TextButton(
          onPressed: onCancel,
          child: Text(cancelBtn ?? 'Cancel'),
        ) : SizedBox(),
        showBtn ? TextButton(
          onPressed: onConfirm,
          child: Text(confirmBtn ?? 'Confirm'),
        ): SizedBox(),
      ],
    );
  }
}
