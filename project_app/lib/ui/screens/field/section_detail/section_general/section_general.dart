import 'package:flutter/material.dart';
import 'package:project_app/core/models/Field.dart';
import 'package:project_app/ui/screens/field/section_detail/section_general/components/section_location.dart';

import 'components/section_info.dart';

class SectionGeneral extends StatelessWidget {
  final Field? field;

  const SectionGeneral({Key? key, @required this.field}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          SectionInfo(field: field!),
          SizedBox(height: 8.0),
          SectionLocation(location: field!.location),
        ],
      ),
    );
  }
}
