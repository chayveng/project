import 'package:flutter/material.dart';
import 'package:project_app/core/models/Time.dart';

class SectionTimes extends StatefulWidget {
  final List<Time>? times;
  const SectionTimes({Key? key, this.times}) : super(key: key);

  @override
  _SectionTimesState createState() => _SectionTimesState();
}

class _SectionTimesState extends State<SectionTimes> {

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text('Times'),
      ),
    );
  }
}
