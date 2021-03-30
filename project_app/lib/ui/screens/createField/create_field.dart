import 'package:flutter/material.dart';
import 'package:project_app/constants.dart';
import 'package:project_app/core/models/Club.dart';
import 'package:project_app/core/models/Field.dart';
import 'package:project_app/core/services/ClubService.dart';
import 'package:project_app/core/services/FieldServices.dart';
import 'package:project_app/ui/components/outline_field.dart';
import 'package:project_app/ui/components/rounded_button.dart';
import 'package:project_app/ui/screens/club/club_screen.dart';

class CreateField extends StatelessWidget {
  final bool isOwner;
  final int clubId;

  const CreateField({
    Key key,
    @required this.isOwner,
    @required this.clubId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: creamPrimaryColor,
      appBar: AppBar(
        title: Text('Create Field'),
      ),
      body: Body(userId: clubId),
    );
  }
}

class Body extends StatefulWidget {
  final int userId;

  const Body({Key key, this.userId}) : super(key: key);
  @override
  _BodyState createState() => _BodyState(userId);
}

class _BodyState extends State<Body> {
  final int userId;
  var _formKey = GlobalKey<FormState>();
  Field field = Field();

  _BodyState(this.userId);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            SizedBox(height: 10),
            OutlineField(
              labelText: 'Title',
              hintText: 'title',
              onSaved: (input) => field.title = input,
            ),
            SizedBox(height: 10),
            OutlineField(
              labelText: 'Detail',
              hintText: 'detail',
              onSaved: (input) => field.detail = input,
            ),
            SizedBox(height: 10),
            OutlineField(
              labelText: 'Price',
              hintText: 'prince',
              onSaved: (input) => field.price = input,
            ),
            SizedBox(height: 10),
            RoundedButton(
              text: 'Create Field',
              onTap: () async {
                _formKey.currentState.save();
                field.clubId = userId;
                var res = await FieldServices.addField(field: field);
                await buildDialogLoading(context, 1000);
                Club _club = await ClubService.getById(id: field.clubId);
                (res == true)
                    ? Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ClubScreen(
                            clubId: _club.id,
                            isOwner: true,
                          ),
                        ),
                      )
                    : print('Create fail');
              },
            ),
          ],
        ),
      ),
    );
  }
}
