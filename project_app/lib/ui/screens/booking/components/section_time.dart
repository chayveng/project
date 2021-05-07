import 'package:flutter/material.dart';
import 'package:project_app/core/models/Time.dart';

class SectionTime extends StatelessWidget {
  final int fieldId;
  final List<Time> times;

  const SectionTime({
    Key key,
    @required this.fieldId,
    @required this.times,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return listSection();
  }

  Widget listSection() {
    return Column(
      children: [
        ...List.generate(
          times.length ?? 0,
          (indexTime) => fieldId == times[indexTime].fieldId
              ? cardTime(indexTime)
              : SizedBox(),
        ),
      ],
    );
  }

  Widget cardTime(int indexTime) {
    return Text(
      '${times[indexTime].startTime} - ${times[indexTime].endTime}',
    );
  }
}
