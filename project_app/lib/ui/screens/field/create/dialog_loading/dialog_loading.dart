import 'package:flutter/material.dart';
import 'package:project_app/ui/components/custom_dialog_loading.dart';

class DialogLoading extends StatefulWidget {
  final Future? onSubmit;
  // final GestureTapCallback onSubmit;

  const DialogLoading({Key? key, @required this.onSubmit}) : super(key: key);

  @override
  _DialogLoadingState createState() => _DialogLoadingState();
}

class _DialogLoadingState extends State<DialogLoading> {
  @override
  void initState() {
    _onSubmit();
    super.initState();
  }

  Future<void> _onSubmit() async {
    await widget.onSubmit;
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return CustomDialogLoading();
  }
}
