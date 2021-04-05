import 'package:flutter/material.dart';
import 'package:project_app/core/models/Field.dart';
import 'package:project_app/ui/screens/club/components/sectionTime/section_time.dart';

import '../../../../../constants.dart';

class CardField extends StatefulWidget {
  final Field field;
  final bool isOwner;
  final VoidCallback onRemoveField;
  final VoidCallback onEdit;

  const CardField({
    Key key,
    @required this.field,
    @required this.isOwner,
    this.onRemoveField,
    this.onEdit,
  }) : super(key: key);

  @override
  _CardFieldState createState() => _CardFieldState();
}

class _CardFieldState extends State<CardField> {
  bool _status = false;

  Widget buttonEdit() => widget.isOwner
      ? IconButton(
          icon: Icon(Icons.edit),
          onPressed: widget.onEdit,
        )
      : SizedBox();

  Widget buttonRemove() => widget.isOwner
      ? IconButton(
          icon: Icon(Icons.remove_circle_outline_rounded),
          onPressed: widget.onRemoveField,
        )
      : SizedBox();

  Widget textField() => Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.field.title),
            Text(widget.field.detail),
            Text(widget.field.price),
          ],
        ),
      );

  GestureDetector cardField({@required BuildContext context}) {
    return GestureDetector(
      onTap: () => setState(() => _status = !_status),
      child: Container(
        width: sized(context).width,
        color: Colors.redAccent,
        child: Row(
          children: [
            textField(),
            buttonEdit(),
            buttonRemove(),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        cardField(context: context),
        SectionTime(
          status: _status,
          isOwner: widget.isOwner,
          fieldId: widget.field.id,
        ),
      ],
    );
  }
}
