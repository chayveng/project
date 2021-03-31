import 'package:flutter/material.dart';
import 'package:project_app/ui/screens/createField/components/form_create.dart';

class Body extends StatefulWidget {
  final int userId;

  const Body({Key key, this.userId}) : super(key: key);
  @override
  _BodyState createState() => _BodyState(userId);
}

class _BodyState extends State<Body> {
  final int userId;

  _BodyState(this.userId);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: FormCreate(),
    );
  }
}
