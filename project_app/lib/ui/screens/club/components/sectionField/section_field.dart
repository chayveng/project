import 'package:flutter/material.dart';
import 'package:project_app/core/models/Field.dart';
import 'package:project_app/core/services/FieldServices.dart';
import 'package:project_app/ui/components/rounded_button.dart';
import 'package:project_app/ui/screens/club/components/sectionTime/section_time.dart';

import 'card_field.dart';
import 'dialog_add.dart';
import 'dialog_remove.dart';

class SectionField extends StatefulWidget {
  final int clubId;
  final bool isOwner;

  const SectionField({
    Key key,
    @required this.clubId,
    @required this.isOwner,
  }) : super(key: key);

  @override
  _SectionFieldState createState() => _SectionFieldState();
}

class _SectionFieldState extends State<SectionField> {
  bool _status = false;
  List<Field> fields = new List<Field>();

  @override
  void initState() {
    fetchData();
    super.initState();
  }

  Future<void> _onEdit({@required int fieldId}) async {
    await showDialog(
          context: context,
          builder: (context) =>
              DialogAdd(clubId: widget.clubId, fieldId: fieldId),
        ) ??
        fetchData();
  }

  Future<void> _onRemoveField(
      {@required BuildContext context, @required int index}) async {
    print('onRemove');
    await showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) {
            return DialogRemove(
              onPressed: () async {
                var res = await FieldServices.delete(id: fields[index].id);
                res ? print('deleted') : print('Fail');
                Navigator.pop(context);
              },
            );
          },
        ) ??
        fetchData();
  }

  Future<void> _onAdd(BuildContext context) async {
    await showDialog(
          context: context,
          builder: (context) => DialogAdd(clubId: widget.clubId),
        ) ??
        fetchData();
  }

  Widget buttonAddField({@required BuildContext context}) => widget.isOwner
      ? Padding(
        padding: const EdgeInsets.all(8.0),
        child: RoundedButton(
            text: 'add field',
            onTap: () async => await _onAdd(context),
          ),
      )
      : SizedBox();

  Widget listSection() => Column(
        children: [
          ...List.generate(
            fields.length ?? 0,
            (index) {
              return sectionField(index: index);
            },
          ),
        ],
      );

  Widget sectionField({@required int index}) => Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 8,left: 8, right: 8),
            child: GestureDetector(
              onTap: () => setState(() => _status = !_status),
              child: CardField(
                field: fields[index],
                isOwner: widget.isOwner,
                onEdit: () async => await _onEdit(fieldId: fields[index].id),
                onRemoveField: () async =>
                    await _onRemoveField(context: context, index: index),
              ),
            ),
          ),
          SectionTime(
            status: _status,
            isOwner: widget.isOwner,
            fieldId: fields[index].id,
          ),
        ],
      );

  Future<bool> fetchData() async {
    fields = await FieldServices.getFieldsClubId(widget.clubId);
    await Future.delayed(Duration(milliseconds: 100), () => setState(() {}));
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          listSection(),
          // SizedBox(height: 10),
          buttonAddField(context: context),
        ],
      ),
    );
  }
}
