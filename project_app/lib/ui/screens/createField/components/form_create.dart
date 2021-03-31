import 'package:flutter/material.dart';
import 'package:project_app/core/models/Field.dart';
import 'package:project_app/ui/components/outline_field.dart';
import 'package:project_app/ui/components/rounded_button.dart';

class FormCreate extends StatefulWidget {
  @override
  _FormCreateState createState() => _FormCreateState();
}

class _FormCreateState extends State<FormCreate> {
  var _formKey = GlobalKey<FormState>();
  Field field = Field();
  double heightPadding = 25;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          SizedBox(height: heightPadding),
          OutlineField(
            labelText: 'Title',
            hintText: 'title',
            onSaved: (input) => field.title = input,
          ),
          SizedBox(height: heightPadding),
          OutlineField(
            labelText: 'Detail',
            hintText: 'detail',
            minLine: 2,
            onSaved: (input) => field.detail = input,
          ),
          SizedBox(height: heightPadding),
          OutlineField(
            labelText: 'Price',
            hintText: 'prince',
            onSaved: (input) => field.price = input,
          ),
          SizedBox(height: heightPadding),
          RoundedButton(
            text: 'Create Field',
            onTap: () async {
              // _formKey.currentState.save();
              // field.clubId = userId;
              // var res = await FieldServices.addField(field: field);
              // await buildDialogLoading(context, 1000);
              // Club _club = await ClubService.getById(id: field.clubId);
              // (res == true)
              //     ? Navigator.push(
              //         context,
              //         MaterialPageRoute(
              //           builder: (context) => ClubScreen(
              //             clubId: _club.id,
              //             isOwner: true,
              //           ),
              //         ),
              //       )
              //     : print('Create fail');
            },
          ),
        ],
      ),
    );
  }
}
