import 'package:flutter/material.dart';
import 'package:project_app/constants.dart';
import 'package:project_app/core/models/User.dart';
import 'package:project_app/core/services/AuthService.dart';
import 'package:project_app/ui/components/rounded_button.dart';
import 'package:project_app/ui/components/rounded_field.dart';
import 'package:project_app/ui/screens/login/login_screen.dart';

class FormRegister extends StatefulWidget {
  @override
  _FormRegisterState createState() => _FormRegisterState();
}

class _FormRegisterState extends State<FormRegister> {
  User user = User();
  String _confirmPass;
  bool _obscureText = true;
  var _formKey = GlobalKey<FormState>();
  Map<String, FocusNode> focusNode = {
    'user': FocusNode(),
    'pass': FocusNode(),
    'conPass': FocusNode(),
    'register': FocusNode(),
    'tel': FocusNode(),
  };

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          buildFieldUsername(context),
          SizedBox(height: 20),
          buildFieldPassword(context),
          SizedBox(height: 20),
          buildFieldConfirmPassword(context),
          SizedBox(height: 20),
          buildFieldTel(context),
          SizedBox(height: 50),
          buildButtonRegister(),
          SizedBox(height: 30),
          buildAlreadyHaveAccount(context),
        ],
      ),
    );
  }

  Future<void> _onRegister() async {
    print('on register');
    // AuthService auth = AuthService();
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      await AuthService.register(user: user)
          ? Navigator.pushReplacementNamed(context, LoginScreen.routeName)
          : _showDialog();
    }
  }

  Future _showDialog() {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        print('User exists');
        return AlertDialog(
          title: Text('Username exists'),
          content: Text('Pleas Try Again.'),
          actions: [
            FlatButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(
                "Ok",
                style: TextStyle(fontSize: 20),
              ),
            ),
          ],
        );
      },
    );
  }

  Row buildAlreadyHaveAccount(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Already have an account?',
          style: TextStyle(
            fontFamily: UiFont,
          ),
        ),
        SizedBox(width: 10),
        InkWell(
          child: Text(
            'Login',
            style: TextStyle(
              fontFamily: UiFont,
              color: orangePrimaryColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          highlightColor: Colors.transparent,
          splashColor: Colors.transparent,
          onTap: () {
            Navigator.pushReplacementNamed(context, LoginScreen.routeName);
          },
        ),
      ],
    );
  }

  RoundedButton buildButtonRegister() {
    return RoundedButton(
      text: 'Register',
      onTap: _onRegister,
    );
  }

  RoundedField buildFieldTel(BuildContext context) {
    return RoundedField(
      keyboardType: TextInputType.number,
      label: 'TEL \:',
      hintText: 'Enter your tel',
      onSaved: (input) => user.tel = input,
      validator: (input) {
        if(input.isEmpty){
          return 'Please enter your tel' ;
        }else if(input.length != 10){
          return 'Tel must be at least 10 characters long';
        }else{
          return null;
        }
      },
      focusNode: focusNode['tel'],
      // onFieldSubmitted: (term) {
      //   focusNode['user'].unfocus();
      //   FocusScope.of(context).requestFocus(focusNode['pass']);
      // },
    );
  }

  RoundedField buildFieldConfirmPassword(BuildContext context) {
    return RoundedField(
      label: 'CONFIRM - PASSWORD \:',
      hintText: 'Enter your password',
      obscureText: _obscureText,
      validator: (input) {
        if (input.isEmpty) {
          return "Please Re-Enter New Password";
        } else if (input.length < 8) {
          return "Password must be at least 8 characters long";
        } else if (input != _confirmPass) {
          return "Password must be same as above";
        } else {
          return null;
        }
      },
      focusNode: focusNode['conPass'],
      onFieldSubmitted: (term) {
        focusNode['conPass'].unfocus();
        FocusScope.of(context).requestFocus(focusNode['tel']);
      },
    );
  }

  RoundedField buildFieldPassword(BuildContext context) {
    return RoundedField(
      label: 'PASSWORD \:',
      hintText: 'Enter your password',
      obscureText: _obscureText,
      onSaved: (input) => user.passWord = input,
      validator: (input) {
        _confirmPass = input;
        if (input.isEmpty) {
          return "Please Enter New Password";
        } else if (input.length < 8) {
          return "Password must be at least 8 characters long";
        } else {
          return null;
        }
      },
      focusNode: focusNode['pass'],
      onFieldSubmitted: (term) {
        focusNode['pass'].unfocus();
        FocusScope.of(context).requestFocus(focusNode['conPass']);
      },
    );
  }

  RoundedField buildFieldUsername(BuildContext context) {
    return RoundedField(
      label: 'USERNAME \:',
      hintText: 'Enter your username',
      onSaved: (input) => user.userName = input,
      validator: (input) => input.isEmpty ? 'Please enter your username' : null,
      focusNode: focusNode['user'],
      onFieldSubmitted: (term) {
        focusNode['user'].unfocus();
        FocusScope.of(context).requestFocus(focusNode['pass']);
      },
    );
  }
}
