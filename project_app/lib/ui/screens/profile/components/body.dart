import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_app/constants.dart';
import 'package:project_app/core/models/User.dart';
import 'package:project_app/core/services/UserService.dart';
import 'package:project_app/ui/screens/profile/components/custom_form_field.dart';
import 'package:project_app/ui/screens/profile/components/custom_top_bar.dart';
import 'package:project_app/ui/screens/profile/components/user_image.dart';

import 'card_menu.dart';

class Body extends StatefulWidget {
  final bool status;

  Body({
    Key key,
    @required this.status,
  }) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final _formKey = GlobalKey<FormState>();
  bool _status = false;
  User _user = User();

  void _onEdit() async {
      var res = _formKey.currentState.save();
    _status
        ? await UserService.update(user: _user)
            ? fetchData()
            : print('update fail')
        : print('is Edit');
    setState(() => _status = !_status);
  }

  void fetchData() async {
    _user = await UserService.getById(userId: await UserService.getUserId());
    await Future.delayed(Duration(milliseconds: 100), () => setState(() {}));
    print(_user);
  }

  @override
  void initState() {
    fetchData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          CustomTopBar(status: _status, onEdit: _onEdit),
          UserImage(userName: _user.userName),
          CustomFormField(status: _status, user: _user),
          RaisedButton(
            onPressed: () async {
              print('save');
              if (_formKey.currentState.validate()) {
                _formKey.currentState.save();
                await UserService.update(user: _user);
                fetchData();
              }
            },
          ),
        ],
      ),
    );
  }
}
