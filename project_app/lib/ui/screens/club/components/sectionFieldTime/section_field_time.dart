import 'package:flutter/material.dart';
import 'package:project_app/core/models/Field.dart';
import 'package:project_app/core/models/Time.dart';
import 'package:project_app/core/services/TimeService.dart';
import 'package:project_app/ui/screens/club/components/sectionFieldTime/section_time.dart';

import '../../../../../constants.dart';
import 'card_field.dart';

class SectionFieldTime extends StatefulWidget {
  final bool isOwner;
  final Field field;

  const SectionFieldTime({
    Key key,
    @required this.isOwner,
    @required this.field,
  }) : super(key: key);

  @override
  _SectionFieldTimeState createState() =>
      _SectionFieldTimeState(isOwner, field);
}

class _SectionFieldTimeState extends State<SectionFieldTime> {
  final bool isOwner;
  final Field field;
  List<Time> times = List<Time>();
  bool _status = false;

  _SectionFieldTimeState(this.isOwner, this.field);

  @override
  void initState() {
    fetchData();
    super.initState();
  }

  Future<void> fetchData() async {
    // times = await TimeService.getByFieldId(fieldId: field.id);
    await Future.delayed(Duration(milliseconds: 300), () =>setState(() {}));
    print(times);
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      width: sized(context).width,
      child: Column(
        children: [
          GestureDetector(
            onTap: () => setState(() => _status = !_status),
            child: CardField(field: field,isOwner: true,),
          ),
          SectionTime(
            clubId: 1,
            isOwner: isOwner,
            status: _status,
            fieldId: field.id,
            times: times ?? List<Time>(),
          ),
        ],
      ),
    );
  }
}
