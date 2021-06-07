import 'package:flutter/material.dart';
import 'package:project_app/constants.dart';
import 'package:project_app/core/models/Field.dart';
import 'package:project_app/ui/components/rounded_button.dart';
import 'package:project_app/ui/screens/field/create/dialog_loading/dialog_loading.dart';

import 'custom_field.dart';

class SectionGeneral extends StatefulWidget {
  final Field? field;
  final bool? isCreate;
  final GlobalKey<FormState>? formKey;
  final GestureTapCallback? onSubmit;

  const SectionGeneral({
    Key? key,
    @required this.field,
    @required this.onSubmit,
    @required this.isCreate,
    @required this.formKey,
  }) : super(key: key);

  @override
  _SectionGeneralState createState() => _SectionGeneralState();
}

class _SectionGeneralState extends State<SectionGeneral> {
  Map<String, dynamic>? focusNode;
  Map<String, dynamic>? textCtl;

  @override
  void initState() {
    setFocusNodeAndTextCtl();
    super.initState();
  }

  Future<void> setFocusNodeAndTextCtl() async {
    textCtl = {
      'title': TextEditingController(text: widget.field!.title ?? ''),
      'detail': TextEditingController(text: widget.field!.detail ?? ''),
      'address': TextEditingController(text: widget.field!.address ?? ''),
      'tel': TextEditingController(text: widget.field!.tel ?? ''),
      'hours': TextEditingController(text: widget.field!.hours ?? ''),
      'price': TextEditingController(text: widget.field!.price ?? ''),
    };
    focusNode = {
      'title': FocusNode(),
      'detail': FocusNode(),
      'address': FocusNode(),
      'tel': FocusNode(),
      'hours': FocusNode(),
      'price': FocusNode(),
    };
    // await Future.delayed(Duration(milliseconds: 1000));
    // setState(() {
    //   print('setTool');
    //   print(textCtl!['title']);
    // });
  }

  Future<void> _onSubmit() async {
    print('delay');
    var onSubmit = widget.onSubmit;
    print('delayed');
    await Future.delayed(Duration(milliseconds: 500));
  }

  Widget buildButton() {
    return RoundedButton(
      text: widget.isCreate! ? 'Create' : 'Update',
      onTap: () async {
        await showDialog(
              context: context,
              builder: (context) => DialogLoading(
                onSubmit: _onSubmit(),
              ),
            ) ??
            Navigator.pop(context);
      },
    );
  }

  Widget telField(BuildContext context) {
    return CustomField(
      labelText: 'Tel',
      hintText: 'tel',
      onSaved: (input) => widget.field!.tel = input,
      onChanged: (input) => widget.field!.tel = input,
      validator: (input) => input.isEmpty ? 'is Empty' : null,
      controller: textCtl!['tel'],
      focusNode: focusNode!['tel'],
    );
  }

  Widget priceField(BuildContext context) {
    return CustomField(
      labelText: 'Price',
      hintText: 'price',
      onSaved: (input) => widget.field!.price = input,
      onChanged: (input) => widget.field!.price = input,
      validator: (input) => input.isEmpty ? 'is Empty' : null,
      keyboardType: TextInputType.datetime,
      controller: textCtl!['price'],
      focusNode: focusNode!['price'],
      onFieldSubmitted: (value) {
        focusNode!['price'].unfocus();
        FocusScope.of(context).requestFocus(focusNode!['tel']);
      },
    );
  }

  Widget openField(BuildContext context) {
    return CustomField(
      labelText: 'Open Time',
      hintText: 'open-time',
      onSaved: (input) => widget.field!.hours = input,
      onChanged: (input) => widget.field!.hours = input,
      validator: (input) => input.isEmpty ? 'is Empty' : null,
      keyboardType: TextInputType.datetime,
      controller: textCtl!['hours'],
      focusNode: focusNode!['hours'],
      onFieldSubmitted: (value) {
        focusNode!['hours'].unfocus();
        FocusScope.of(context).requestFocus(focusNode!['price']);
      },
    );
  }

  Widget detailField(BuildContext context) {
    return CustomField(
      labelText: 'Detail',
      hintText: 'detail',
      maxLine: 5,
      onSaved: (input) => widget.field!.detail = input,
      onChanged: (input) => widget.field!.detail = input,
      validator: (input) => input.isEmpty ? 'is Empty' : null,
      controller: textCtl!['detail'],
      focusNode: focusNode!['detail'],
      onFieldSubmitted: (value) {
        focusNode!['detail'].unfocus();
        FocusScope.of(context).requestFocus(focusNode!['hours']);
      },
    );
  }

  Widget titleField(BuildContext context) {
    return CustomField(
      labelText: 'Title',
      hintText: 'title',
      onSaved: (input) => widget.field!.title = input,
      onChanged: (input) => widget.field!.title = input,
      validator: (input) => input.isEmpty ? 'is Empty' : null,
      controller: textCtl!['title'],
      focusNode: focusNode!['title'],
      onFieldSubmitted: (value) {
        focusNode!['title'].unfocus();
        FocusScope.of(context).requestFocus(focusNode!['detail']);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // setFocusNodeAndTextCtl();
    textCtl = {
      'title': TextEditingController(text: widget.field!.title ?? ''),
      'detail': TextEditingController(text: widget.field!.detail ?? ''),
      'address': TextEditingController(text: widget.field!.address ?? ''),
      'tel': TextEditingController(text: widget.field!.tel ?? ''),
      'hours': TextEditingController(text: widget.field!.hours ?? ''),
      'price': TextEditingController(text: widget.field!.price ?? ''),
    };
    setState(() {});
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
          ],
        ),
      ),
    );
  }
}
