import 'package:flutter/material.dart';
import 'package:project_app/core/models/Club.dart';
import 'package:project_app/core/models/Field.dart';
import 'package:project_app/core/models/Time.dart';
import 'package:project_app/core/services/ClubService.dart';
import 'package:project_app/core/services/FieldServices.dart';
import 'package:project_app/ui/components/rounded_button.dart';

import '../../../../../constants.dart';
import 'custom_field.dart';

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
  Map<String, dynamic> focusNode = {
    'title': FocusNode(),
    'detail': FocusNode(),
    'price': FocusNode(),
  };
  var tester;

  @override
  void initState() {
    fetchData();
    Future.delayed(Duration(milliseconds: 200), () => setState(() {}));
    super.initState();
  }

  void setDefaultInput() {
    textCtl = {
      'title': TextEditingController(text: field.title ?? ''),
      'detail': TextEditingController(text: field.detail ?? ''),
      'price': TextEditingController(text: field.price ?? ''),
    };
  }

  Future<void> fetchData() async {
    field = (widget.fieldId != null)
        ? await FieldServices.getFieldById(id: widget.fieldId)
        : Field();
  }

  Future<void> _onUpdateAndCreate(BuildContext context) async {
    _formKey.currentState.save();
    field.clubId = widget.clubId;
    var res = await FieldServices.addField(field: field);
    await buildDialogLoading(context, 1000);
    Club _club = await ClubService.getById(id: field.clubId);
    (res == true) ? Navigator.pop(context) : print('Create fail');
  }

  Widget buttonUpdateOrCreate(BuildContext context) {
    return RoundedButton(
      text: (widget.isCreate) ? 'Update' : 'Create',
      onTap: () async =>  _onUpdateAndCreate(context),
    );
  }

  CustomField priceField() {
    return CustomField(
      hintText: 'price',
      onSaved: (input) => field.price = input,
      controller: textCtl['price'],
      focusNode: focusNode['price'],
    );
  }

  CustomField detailField() {
    return CustomField(
      hintText: 'detail',
      onSaved: (input) => field.detail = input,
      controller: textCtl['detail'],
      focusNode: focusNode['detail'],
      onFieldSubmitted: (term) {
        focusNode['detail'].unfocus();
        FocusScope.of(context).requestFocus(focusNode['price']);
      },
    );
  }

  CustomField titleField() {
    return CustomField(
      hintText: 'title',
      onSaved: (input) => field.title = input,
      controller: textCtl['title'],
      focusNode: focusNode['title'],
      onFieldSubmitted: (term) {
        focusNode['title'].unfocus();
        FocusScope.of(context).requestFocus(focusNode['detail']);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    setDefaultInput();
    return AlertDialog(
      title: Text('Add Field'),
      content: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              titleField(),
              detailField(),
              priceField(),
              SizedBox(height: 10),
              buttonUpdateOrCreate(context),
            ],
          ),
        ),
      ),
    );
  }
}
