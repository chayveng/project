import 'package:flutter/material.dart';
import 'package:project_app/constants.dart';

import 'body.dart';

class FieldScreen extends StatelessWidget {
  final bool? isOwner;
  final int? fieldId;

  const FieldScreen({
    Key? key,
    @required this.isOwner,
    @required this.fieldId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(isOwner: isOwner,fieldId: fieldId),
    );
  }
}
