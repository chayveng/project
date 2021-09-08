import 'package:flutter/material.dart';
import 'package:project_app/constants.dart';

import 'body.dart';

class CreateFieldScreen extends StatelessWidget {
  final bool? isCreate;
  final int? fieldId;

  const CreateFieldScreen({
    Key? key,
    @required this.isCreate,
    this.fieldId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: greyColor,
      appBar: AppBar(
        title: Text('สร้างสนาม'),
      ),
      body: Body(isCreate: isCreate, fieldId: fieldId),
    );
  }
}
