import 'package:flutter/material.dart';
import 'package:project_app/constants.dart';
import 'package:project_app/core/models/Club.dart';
import 'package:project_app/ui/components/rounded_button.dart';

import 'custom_field.dart';

class SectionField extends StatefulWidget {
  final Club club;
  final bool isCreate;
  final formKey;
  final GestureTapCallback onSubmit;

  const SectionField({
    Key key,
    this.club,
    this.onSubmit,
    this.isCreate,
    this.formKey,
  }) : super(key: key);

  @override
  _SectionFieldState createState() => _SectionFieldState();
}

class _SectionFieldState extends State<SectionField> {
  Map<String, dynamic> focusNode;
  Map<String, dynamic> textCtl;
  List<String> keys = ['title', 'detail', 'open', 'price', 'tel'];

  @override
  void initState() {
    super.initState();
  }

  void setTool() {
    focusNode = SetTools.setFocusNode();
    textCtl = SetTools.setTextCtl(club: widget.club);
  }

  Widget buildButton() {
    return SafeArea(
      child: RoundedButton(
        text: widget.isCreate ? 'update' : 'Create',
        onTap: widget.onSubmit,
      ),
    );
  }

  Widget telField(BuildContext context) {
    int index = 4;
    return CustomField(
      labelText: 'Tel',
      hintText: 'tel',
      onSaved: (input) => widget.club.tel = input,
      onChanged: (input) => widget.club.tel = input,
      validator: (input) => input.isEmpty ? 'is Empty' : null,
      controller: textCtl[keys[index]],
      focusNode: focusNode[keys[index]],
      onFieldSubmitted: (value) {
        focusNode[keys[index]].unfocus();
        FocusScope.of(context).requestFocus(focusNode[keys[index++]]);
      },
    );
  }

  Widget priceField(BuildContext context) {
    int index = 3;
    return CustomField(
      labelText: 'Price',
      hintText: 'price',
      onSaved: (input) => widget.club.price = input,
      onChanged: (input) => widget.club.price = input,
      validator: (input) => input.isEmpty ? 'is Empty' : null,
      keyboardType: TextInputType.datetime,
      controller: textCtl[keys[index]],
      focusNode: focusNode[keys[index]],
      onFieldSubmitted: (value) {
        focusNode[keys[index]].unfocus();
        FocusScope.of(context).requestFocus(focusNode[keys[index++]]);
      },
    );
  }

  Widget openField(BuildContext context) {
    int index = 2;
    return CustomField(
      labelText: 'Open Time',
      hintText: 'open-time',
      onSaved: (input) => widget.club.open = input,
      onChanged: (input) => widget.club.open = input,
      validator: (input) => input.isEmpty ? 'is Empty' : null,
      keyboardType: TextInputType.datetime,
      controller: textCtl[keys[index]],
      focusNode: focusNode[keys[index]],
      onFieldSubmitted: (value) {
        focusNode[keys[index]].unfocus();
        FocusScope.of(context).requestFocus(focusNode[keys[index++]]);
      },
    );
  }

  Widget detailField(BuildContext context) {
    int index = 1;
    return CustomField(
      labelText: 'Detail',
      hintText: 'detail',
      maxLine: 5,
      onSaved: (input) => widget.club.detail = input,
      onChanged: (input) => widget.club.detail = input,
      validator: (input) => input.isEmpty ? 'is Empty' : null,
      controller: textCtl[keys[index]],
      focusNode: focusNode[keys[index]],
      onFieldSubmitted: (value) {
        focusNode[keys[index]].unfocus();
        FocusScope.of(context).requestFocus(focusNode[keys[index++]]);
      },
    );
  }

  Widget titleField(BuildContext context) {
    int index = 0;
    return CustomField(
      labelText: 'Title',
      hintText: 'title',
      onSaved: (input) => widget.club.title = input,
      onChanged: (input) => widget.club.title = input,
      validator: (input) => input.isEmpty ? 'is Empty' : null,
      controller: textCtl[keys[index]],
      focusNode: focusNode[keys[index]],
      onFieldSubmitted: (value) {
        focusNode[keys[index]].unfocus();
        FocusScope.of(context).requestFocus(focusNode[keys[index++]]);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    setTool();
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
      child: Form(
        key: widget.formKey,
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: creamPrimaryColor,
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Icon(Icons.circle_notifications),
                      SizedBox(width: 10),
                      Text(
                        'General',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                  SizedBox(height: 12),
                  titleField(context),
                  SizedBox(height: 8),
                  detailField(context),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      Expanded(child: openField(context)),
                      SizedBox(width: 20),
                      Expanded(child: priceField(context)),
                    ],
                  ),
                  SizedBox(height: 8),
                  telField(context),
                  SizedBox(height: 8),
                ],
              ),
            ),
            SizedBox(height: 10),
            buildButton(),
            // SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}

class SetTools {
  static Map<String, dynamic> setTextCtl({@required Club club}) {
    return {
      'title': TextEditingController(text: club.title ?? ''),
      'detail': TextEditingController(text: club.detail ?? ''),
      'open': TextEditingController(text: club.open ?? ''),
      'price': TextEditingController(text: club.price ?? ''),
      'tel': TextEditingController(text: club.tel ?? ''),
    };
  }

  static Map<String, dynamic> setFocusNode() {
    return {
      'title': FocusNode(),
      'detail': FocusNode(),
      'open': FocusNode(),
      'price': FocusNode(),
      'tel': FocusNode(),
    };
  }
}
