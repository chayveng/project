import 'package:flutter/material.dart';
import 'package:project_app/core/models/Time.dart';

class SectionTimes extends StatelessWidget {
  final List<Time> times;
  const SectionTimes({Key key, this.times}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text('Times'),
      ),
    );
  }
}
