import 'package:flutter/material.dart';
import 'package:project_app/core/models/Field.dart';
import 'package:project_app/ui/screens/field/section_detail/components/form_tab.dart';
import 'package:project_app/ui/screens/field/section_detail/section_general/section_general.dart';
import 'package:project_app/ui/screens/field/section_detail/section_reserve/section_reserve.dart';
import 'package:project_app/ui/screens/field/section_detail/section_times/section_time.dart';

class SectionDetail extends StatefulWidget {
  final Field? field;
  final bool? isOwner;
  final int? fieldId;

  const SectionDetail({
    Key? key,
    @required this.field,
    @required this.isOwner,
    @required this.fieldId,
  }) : super(key: key);

  @override
  _SectionDetailState createState() => _SectionDetailState();
}

class _SectionDetailState extends State<SectionDetail> {
  @override
  Widget build(BuildContext context) {
    return FormTab(
      tabBars: widget.isOwner!
          ? ['ข้อมูลสนาม', 'เวลา', 'จอง']
          : ['ข้อมูลสนาม', 'เวลา'],
      tabViews: [
        SectionGeneral(field: widget.field),
        SectionTime(isOwner: widget.isOwner, fieldId: widget.fieldId),
        widget.isOwner!
            ? SectionReserve(
                isOwner: widget.isOwner,
                fieldId: widget.fieldId,
          isReserve: true,
              )
            : SizedBox(),
      ],
    );
  }
}
