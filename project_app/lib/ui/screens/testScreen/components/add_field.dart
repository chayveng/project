import 'package:flutter/material.dart';
import 'package:project_app/core/models/Field.dart';
import 'package:project_app/core/services/FieldServices.dart';

import '../../../../constants.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  bool isOwner = false;
  Field field = new Field();
  List<Field> fields = new List<Field>();

  var _formKey = GlobalKey<FormState>();

  Future<void> fetchFields() async {
    await Future.delayed(Duration(milliseconds: 1000));
    fields = await FieldServices.fetchFields();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextFormField(
                onSaved: (input) => field.title = input,
                decoration: InputDecoration(
                  hintText: 'title',
                ),
              ),
              TextFormField(
                onSaved: (input) => field.detail = input,
                decoration: InputDecoration(
                  hintText: 'detail',
                ),
              ),
              TextFormField(
                onSaved: (input) => field.price = input,
                decoration: InputDecoration(
                  hintText: 'price',
                ),
              ),
              RaisedButton(
                child: Text("Add"),
                onPressed: () {
                  _formKey.currentState.save();
                  print(field);
                  // print("add");
                },
              ),
              RaisedButton(
                child: Text("Fields"),
                onPressed: () {
                  print(fields);
                  FieldServices.addField(field: field);
                  fetchFields();
                  setState(() {});
                },
              ),
              ...List.generate(
                fields == null ? 0 : fields.length,
                    (index) => Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: sized(context).width,
                    padding: EdgeInsets.all(8),
                    color: Colors.yellow,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("ID: ${fields[index].id}"),
                        Text("ClubID: ${fields[index].clubId}"),
                        Text("${fields[index].title}"),
                        Text("${fields[index].detail}"),
                        Text("${fields[index].price}"),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}