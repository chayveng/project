import 'package:flutter/material.dart';
import 'package:project_app/core/models/Field.dart';
import 'package:project_app/core/services/FieldServices.dart';
import 'package:project_app/ui/components/rounded_button.dart';
import 'package:project_app/ui/screens/club/components/sectionTime/section_time.dart';
import 'package:project_app/ui/screens/createField/create_field.dart';

import '../../../../../constants.dart';
import 'card_field.dart';

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

  Future<void> _onRemoveField(
      {@required BuildContext context, @required int index}) async {
    print('onRemove');
    await showDialog(
          context: context,
          builder: (context) {
            return DialogConfirm(
              fieldId: fields[index].id,
            );
          },
        ) ??
        await fetchData();
  }

  Widget buttonAddField({@required BuildContext context}) => widget.isOwner
      ? RoundedButton(
          text: 'add field',
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CreateField(
                  clubId: widget.clubId,
                ),
              ),
            );
          },
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
        GestureDetector(
          onTap: () => setState(() => _status = !_status),
          child: CardField(
            field: fields[index],
            isOwner: widget.isOwner,
            onRemoveField: () async =>
                _onRemoveField(context: context, index: index),
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
    fields = await FieldServices.getFieldClubId(widget.clubId);
    await Future.delayed(Duration(milliseconds: 500), () => setState(() {}));
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          listSection(),
          SizedBox(height: 10),
          buttonAddField(context: context),
        ],
      ),
    );
  }
}

class DialogConfirm extends StatelessWidget {
  final fieldId;
  final timeId;
  final clubId;

  const DialogConfirm({
    Key key,
    this.timeId,
    this.clubId,
    this.fieldId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        width: sized(context).width,
        height: 200,
        child: RaisedButton(
          child: Text('Confirm'),
          onPressed: () async {
            print(fieldId);
            var res = await FieldServices.delete(id: fieldId);
            res ? print('deleted') : print('Fail');
            Navigator.pop(context);
          },
        ),
      ),
    );
  }
}
