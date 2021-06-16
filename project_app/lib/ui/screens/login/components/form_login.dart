import 'package:flutter/material.dart';
import 'package:project_app/core/models/User.dart';
import 'package:project_app/core/services/AuthService.dart';
import 'package:project_app/core/services/UserService.dart';
import 'package:project_app/ui/components/rounded_button.dart';
import 'package:project_app/ui/components/rounded_field.dart';
import 'package:project_app/ui/screens/main/main_screen.dart';
import 'package:project_app/ui/screens/register/register_screen.dart';

import '../../../../constants.dart';

class FormLogin extends StatefulWidget {
  @override
  _FormLoginState createState() => _FormLoginState();
}

class _FormLoginState extends State<FormLogin> {
  User user = User();
  bool _obscureText = true;
  var _formKey = GlobalKey<FormState>();
  Map<String, FocusNode> focusNode = {
    'user': FocusNode(),
    'pass': FocusNode(),
    'login': FocusNode(),
  };

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          buildFieldUsername(context),
          SizedBox(height: 25),
          buildFieldPassword(context),
          SizedBox(height: 55),
          buildButtonLogin(),
          SizedBox(height: 80),
          buildDoNotHaveAccount(context),
        ],
      ),
    );
  }

  Future<void> _onLogin() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      await UserService.login(user: user)
          ? Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => MainScreen()),
              (route) => false)
          : _showDialog();
    }
  }

  Future _showDialog() {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Username or Password is incorrect."),
          content: Text("Pleas Try Again."),
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

  Row buildDoNotHaveAccount(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('Don\'t have an account?'),
        SizedBox(width: 10),
        InkWell(
          child: Text(
            'Register',
            style: TextStyle(
              fontFamily: UiFont,
              fontWeight: FontWeight.bold,
              color: orangePrimaryColor,
            ),
          ),
          highlightColor: Colors.transparent,
          splashColor: Colors.transparent,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => RegisterScreen(),
              ),
            );
          },
          autofocus: true,
        ),
      ],
    );
  }

  RoundedButton buildButtonLogin() {
    return RoundedButton(
      text: 'Login',
      onTap: _onLogin,
    );
  }

  RoundedField buildFieldPassword(BuildContext context) {
    return RoundedField(
      label: 'PASSWORD \:',
      hintText: 'Enter your password',
      obscureText: _obscureText,
      onSaved: (input) => user.passWord = input,
      validator: (input) {
        if (input.isEmpty) {
          return "Please Enter New Password";
        } else if (input.length < 8) {
          return "Password must be at least 8 characters long";
        } else {
          return null;
        }
      },
      focusNode: focusNode['pass']!,
    );
  }

  RoundedField buildFieldUsername(BuildContext context) {
    return RoundedField(
      label: 'USERNAME \:',
      hintText: 'Enter your username',
      onSaved: (input) => user.userName = input,
      validator: (input) => input.isEmpty ? 'Please enter your username' : null,
      focusNode: focusNode['user']!,
      onFieldSubmitted: (term) {
        focusNode['user']!.unfocus();
        FocusScope.of(context).requestFocus(focusNode['pass']);
      },
    );
  }
}
