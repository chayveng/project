import 'package:flutter/material.dart';
import 'package:project_app/core/models/Club.dart';
import 'package:project_app/core/models/Field.dart';
import 'package:project_app/core/models/Time.dart';
import 'package:project_app/core/services/ClubService.dart';
import 'package:project_app/core/services/FieldServices.dart';
import 'package:project_app/ui/components/outline_field.dart';
import 'package:project_app/ui/components/rounded_button.dart';

import '../../../../../constants.dart';

class DialogAdd extends StatefulWidget {
  final int fieldId;
  final int clubId;
  final bool isCreate;

  const DialogAdd({
    Key key,
    this.fieldId,
    this.clubId,
    this.isCreate = false,
  }) : super(key: key);

  @override
  _DialogAddState createState() => _DialogAddState();
}

class _DialogAddState extends State<DialogAdd> {
  final _formKey = GlobalKey<FormState>();
  Field field = Field();
  List<Time> times = List<Time>();
  Map<String, dynamic> textCtl;

  @override
  void initState() {
    fetchData();
    Future.delayed(Duration(milliseconds: 200), () => setState(() {}));
    super.initState();
  }

  Future<void> fetchData() async {
    field = (widget.fieldId != null)
        ? await FieldServices.getFieldById(id: widget.fieldId)
        : Field();
  }

  void setDefaultInput() {
    textCtl = {
      'title': TextEditingController(text: field.title ?? ''),
      'detail': TextEditingController(text: field.detail ?? ''),
      'price': TextEditingController(text: field.price ?? ''),
    };
  }

  @override
  Widget build(BuildContext context) {
    setDefaultInput();
    return Dialog(
      backgroundColor: Colors.transparent,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Container(
          color: Colors.white,
          child: Container(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  SizedBox(height: 10),
                  OutlineField(
                    labelText: 'Title',
                    hintText: 'title',
                    controller: textCtl['title'],
                    onSaved: (input) => field.title = input,
                  ),
                  SizedBox(height: 10),
                  OutlineField(
                    labelText: 'Detail',
                    hintText: 'detail',
                    controller: textCtl['detail'],
                    onSaved: (input) => field.detail = input,
                  ),
                  SizedBox(height: 10),
                  OutlineField(
                    labelText: 'Price',
                    hintText: 'prince',
                    controller: textCtl['price'],
                    onSaved: (input) => field.price = input,
                  ),
                  SizedBox(height: 10),
                  RoundedButton(
                    text: (widget.isCreate) ? 'Update' : 'Create',
                    onTap: () async {
                      _formKey.currentState.save();
                      field.clubId = widget.clubId;
                      var res = await FieldServices.addField(field: field);
                      await buildDialogLoading(context, 1000);
                      Club _club = await ClubService.getById(id: field.clubId);
                      (res == true)
                          ? Navigator.pop(context)
                          : print('Create fail');
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
