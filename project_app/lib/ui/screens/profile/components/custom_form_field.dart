import 'package:flutter/material.dart';
import 'package:project_app/core/models/User.dart';
import '../../../../constants.dart';
import 'card_menu.dart';
import 'package:validators/validators.dart';

class CustomFormField extends StatefulWidget {
  final bool status;
  final User user;

  const CustomFormField({
    Key key,
    @required this.status,
    @required this.user,
  }) : super(key: key);

  @override
  _CustomFormFieldState createState() => _CustomFormFieldState();
}

class _CustomFormFieldState extends State<CustomFormField> {
  final double _sizedOfImageUser = 100;
  Map<String, FocusNode> focusNode = {
    'firstName': FocusNode(),
    'lastName': FocusNode(),
    'email': FocusNode(),
    'tel': FocusNode(),
  };

  Widget tel() {
    return CardMenu(
      status: widget.status,
      title: widget.user.tel,
      hintText: 'Tel',
      keyboardType: TextInputType.number,
      onSaved: (input) => widget.user.tel = (input == '') ? null : input,
      focusNode: focusNode['tel'],
      onFieldSubmitted: (term) {
        focusNode['tel'].unfocus();
      },
      validator: (input) {
        if(input.isEmpty){
          return 'Please enter your tel' ;
        }else if(input.length < 10){
          return 'Tel must be at least 10 characters long';
        }else{
          return null;
        }
      },
    );
  }

  Widget email() {
    return CardMenu(
      status: widget.status,
      title: widget.user.email,
      hintText: 'Email',
      keyboardType: TextInputType.emailAddress,
      onSaved: (input) => widget.user.email = (input == '') ? null : input,
      focusNode: focusNode['email'],
      onFieldSubmitted: (term) {
        focusNode['email'].unfocus();
        FocusScope.of(context).requestFocus(focusNode['tel']);
      },
      validator: (input){
        if(!isEmail(input)){
          return 'Email is not correct.';
        }else{
          return null;
        }
      },
    );
  }

  Widget lastName() {
    return CardMenu(
      status: widget.status,
      title: widget.user.lastName,
      hintText: 'LastName',
      onSaved: (input) => widget.user.lastName = (input == '') ? null : input,
      focusNode: focusNode['lastName'],
      onFieldSubmitted: (term) {
        focusNode['lastName'].unfocus();
        FocusScope.of(context).requestFocus(focusNode['email']);
      },
    );
  }

  Widget firstName() {
    return CardMenu(
      status: widget.status,
      title: widget.user.firstName,
      hintText: 'FirstName',
      onSaved: (input) => widget.user.firstName = input == '' ? null : input,
      focusNode: focusNode['firstName'],
      onFieldSubmitted: (term) {
        focusNode['firstName'].unfocus();
        FocusScope.of(context).requestFocus(focusNode['lastName']);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
        color: creamPrimaryColor,
        borderRadius: BorderRadius.circular(20),
      ),
      width: sized(context).width,
      child: SingleChildScrollView(
        child: Column(
          children: [
            firstName(),
            SizedBox(height: 20),
            lastName(),
            SizedBox(height: 20),
            email(),
            SizedBox(height: 20),
            tel(),
          ],
        ),
      ),
    );
  }
}
