import 'package:flutter/material.dart';
import 'package:project_app/constants.dart';
import 'package:project_app/core/models/Field.dart';
import 'package:project_app/ui/components/title_form_field.dart';

import 'custom_field.dart';

class SectionGeneral extends StatefulWidget {
  final Field? field;
  final bool? isCreate;
  final GlobalKey<FormState>? formKey;

  const SectionGeneral({
    Key? key,
    @required this.field,
    @required this.isCreate,
    @required this.formKey,
  }) : super(key: key);

  @override
  _SectionGeneralState createState() => _SectionGeneralState();
}

class _SectionGeneralState extends State<SectionGeneral> {
  Map<String, dynamic>? focusNode;
  Map<String, dynamic>? textCtl;
  List<String> keys = ['title', 'detail', 'open', 'price', 'tel'];

  @override
  void initState() {
    super.initState();
  }

  void setTool() {
    focusNode = SetTools.setFocusNode();
  }

  Widget telField(BuildContext context) {
    int index = 4;
    return CustomField(
<<<<<<< HEAD
      labelText: 'เบอร์โทรติดต่อ',
      hintText: 'เบอร์โทรติดต่อ',
=======
      labelText: 'Tel',
      hintText: 'tel',
>>>>>>> master
      onSaved: (input) => widget.field!.tel = input,
      onChanged: (input) => widget.field!.tel = input,
      validator: (input) => input.isEmpty ? 'is Empty' : null,
      controller: TextEditingController(text: widget.field!.tel),
      keyboardType: TextInputType.number,
      focusNode: focusNode![keys[index]],
      onFieldSubmitted: (value) {
        focusNode![keys[index]].unfocus();
        FocusScope.of(context).requestFocus(focusNode![keys[index++]]);
      },
    );
  }

  Widget priceField(BuildContext context) {
    int index = 3;
    return CustomField(
<<<<<<< HEAD
      labelText: 'ราคา',
      hintText: 'เช่น 600/700',
=======
      labelText: 'Price',
      hintText: 'price',
>>>>>>> master
      onSaved: (input) => widget.field!.price = input,
      onChanged: (input) => widget.field!.price = input,
      validator: (input) => input.isEmpty ? 'is Empty' : null,
      keyboardType: TextInputType.number,
      controller: TextEditingController(text: widget.field!.price),
      focusNode: focusNode![keys[index]],
      onFieldSubmitted: (value) {
        focusNode![keys[index]].unfocus();
        FocusScope.of(context).requestFocus(focusNode![keys[index++]]);
      },
    );
  }

  Widget openField(BuildContext context) {
    int index = 2;
    return CustomField(
<<<<<<< HEAD
      labelText: 'เวลาเปิด/ปิด',
      hintText: 'เช่น 12:00-23:00',
=======
      labelText: 'Open Time',
      hintText: 'open-time',
>>>>>>> master
      onSaved: (input) => widget.field!.hours = input,
      onChanged: (input) => widget.field!.hours = input,
      validator: (input) => input.isEmpty ? 'is Empty' : null,
      keyboardType: TextInputType.datetime,
      controller: TextEditingController(text: widget.field!.hours),
      focusNode: focusNode![keys[index]],
      onFieldSubmitted: (value) {
        focusNode![keys[index]].unfocus();
        FocusScope.of(context).requestFocus(focusNode![keys[index++]]);
      },
    );
  }

  Widget detailField(BuildContext context) {
    int index = 1;
    return CustomField(
<<<<<<< HEAD
      labelText: 'รายละเอียดสนาม',
      hintText: 'เช่น สนามขนาด 7-9 คน',
=======
      labelText: 'Detail',
      hintText: 'detail',
>>>>>>> master
      maxLine: 5,
      onSaved: (input) => widget.field!.detail = input,
      onChanged: (input) => widget.field!.detail = input,
      validator: (input) => input.isEmpty ? 'is Empty' : null,
      controller: TextEditingController(text: widget.field!.detail),
      focusNode: focusNode![keys[index]],
      onFieldSubmitted: (value) {
        focusNode![keys[index]].unfocus();
        FocusScope.of(context).requestFocus(focusNode![keys[index++]]);
      },
    );
  }

  Widget titleField(BuildContext context) {
    int index = 0;
    return CustomField(
<<<<<<< HEAD
      labelText: 'ชื่อสนาม',
      hintText: 'ชื่อสนาม',
=======
      labelText: 'Title',
      hintText: 'title',
>>>>>>> master
      onSaved: (input) => widget.field!.title = input,
      onChanged: (input) => widget.field!.title = input,
      validator: (input) => input.isEmpty ? 'is Empty' : null,
      controller: TextEditingController(text: widget.field!.title),
      focusNode: focusNode![keys[index]],
      onFieldSubmitted: (value) {
        focusNode![keys[index]].unfocus();
        FocusScope.of(context).requestFocus(focusNode![keys[index++]]);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    setTool();
    return Form(
      key: widget.formKey,
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: whiteColor,
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
            ),
            child: Column(
              children: [
                TitleFormField(
                  iconData: Icons.circle_notifications,
<<<<<<< HEAD
                  title: 'ข้อมูลสนาม',
=======
                  title: 'General',
>>>>>>> master
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
        ],
      ),
    );
  }
}

class SetTools {
  static Map<String, dynamic> setFocusNode() {
    return {
      'title': FocusNode(),
      'detail': FocusNode(),
      'address': FocusNode(),
      'tel': FocusNode(),
      'hours': FocusNode(),
      'price': FocusNode(),
    };
  }
}
