import 'package:flutter/material.dart';
import 'package:project_app/core/models/Field.dart';
import 'package:project_app/core/models/Time.dart';
import 'package:project_app/ui/screens/booking/components/section_time.dart';

class SectionField extends StatelessWidget {
  final int clubId;
  final List<Time> times;
  final List<Field> fields;

  const SectionField({
    Key key,
    @required this.clubId,
    @required this.fields,
    @required this.times,
  }) : super(key: key);

  Widget cardField(int indexField) {
    return clubId == fields[indexField].clubId
        ? Column(
            children: [
              Row(
                children: [
                  SizedBox(width: 60),
                  Text(
                    fields[indexField].title,
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
              SectionTime(
                fieldId: fields[indexField].id,
                times: times,
              ),
            ],
          )
        : SizedBox();
  }

  Widget listSection() {
    return Column(
      children: [
        ...List.generate(
          fields.length ?? 0,
          (indexField) => cardField(indexField),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return listSection();
  }
}
