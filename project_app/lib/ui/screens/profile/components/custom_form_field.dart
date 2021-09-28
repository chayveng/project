import 'package:flutter/material.dart';
import 'package:project_app/core/models/User.dart';
import 'package:validators/validators.dart';

import '../../../../constants.dart';
import 'card_menu.dart';

class CustomFormField extends StatefulWidget {
  final bool? status;
  final User? user;
  final Map<String, dynamic>? focusNode;

  const CustomFormField({
    Key? key,
    @required this.status,
    @required this.user,
    @required this.focusNode,
  }) : super(key: key);

  @override
  _CustomFormFieldState createState() => _CustomFormFieldState();
}

class _CustomFormFieldState extends State<CustomFormField> {
  User? _user = User();

  @override
  initState() {
    _user = widget.user;
    super.initState();
  }

  Widget tel(BuildContext context) {
    return CardMenu(
      status: widget.status,
      title: _user!.tel ?? widget.user!.tel,
      onChanged: (value) => _user!.tel = value,
      hintText: 'เบอร์โทรศัพท์',
      onSaved: (input) => widget.user!.tel = (input == '') ? null : input,
      keyboardType: TextInputType.number,
      focusNode: widget.focusNode!['tel'],
      onFieldSubmitted: (term) {
        widget.focusNode!['tel'].unfocus();
      },
      validator: (input) {
        if (input.isEmpty) {
          return 'Please enter your tel';
        } else if (!isNumeric(input)) {
          return 'Please enter Numeric';
        } else if (input.length != 10) {
          return 'Tel must be at least 10 characters long';
        } else {
          return null;
        }
      },
    );
  }

  Widget email(BuildContext context) {
    return CardMenu(
      status: widget.status,
      title: _user!.email ?? widget.user!.email,
      onChanged: (value) => _user!.email = value,
      hintText: 'อีเมลล์',
      onSaved: (input) => widget.user!.email = (input == '') ? null : input,
      focusNode: widget.focusNode!['email'],
      onFieldSubmitted: (term) {
        widget.focusNode!['email'].unfocus();
        FocusScope.of(context).requestFocus(widget.focusNode!['tel']);
      },
    );
  }

  Widget lastName(BuildContext context) {
    return CardMenu(
      status: widget.status,
      title: _user!.lastName ?? widget.user!.lastName,
      onChanged: (value) => _user!.lastName = value,
      hintText: 'นามสกุล',
      onSaved: (input) => widget.user!.lastName = (input == '') ? null : input,
      focusNode: widget.focusNode!['lastName'],
      onFieldSubmitted: (term) {
        widget.focusNode!['lastName'].unfocus();
        FocusScope.of(context).requestFocus(widget.focusNode!['email']);
      },
    );
  }

  Widget firstName(BuildContext context) {
    return CardMenu(
      status: widget.status,
      title: _user!.firstName ?? widget.user!.firstName,
      onChanged: (value) => _user!.firstName = value,
      hintText: 'ชื่อ',
      onSaved: (input) => widget.user!.firstName = input == '' ? null : input,
      focusNode: widget.focusNode!['firstName'],
      onFieldSubmitted: (term) {
        widget.focusNode!['firstName'].unfocus();
        FocusScope.of(context).requestFocus(widget.focusNode!['lastName']);
      },
    );
  }
  Row titleBar() {
    return Row(
      children: [
        Icon(
          Icons.info,
          color: navyPrimaryColor,
        ),
        SizedBox(width: 10),
        Text(
          'ข้อมูลส่วนตัว',
          style: TextStyle(color: navyPrimaryColor),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
        color: whiteColor,
        borderRadius: BorderRadius.circular(20),
      ),
      width: sized(context).width,
      child: SingleChildScrollView(
        child: Column(
          children: [
            titleBar(),
            firstName(context),
            lastName(context),
            email(context),
            tel(context),
          ],
        ),
      ),
    );
  }

}
