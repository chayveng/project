import 'package:flutter/material.dart';
import 'package:project_app/constants.dart';
import 'package:project_app/core/models/Club.dart';
import 'package:project_app/core/models/Field.dart';
import 'package:project_app/core/models/Time.dart';
import 'package:project_app/core/services/ClubService.dart';
import 'package:project_app/core/services/FieldServices.dart';
import 'package:project_app/ui/components/outline_field.dart';
import 'package:project_app/ui/components/rounded_button.dart';
import 'package:project_app/ui/screens/club/club_screen.dart';

class CreateField extends StatelessWidget {
  final int fieldId;
  final int clubId;
  final bool isCreate;

  const CreateField({
    Key key,
    @required this.clubId,
    this.fieldId,
    this.isCreate = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: creamPrimaryColor,
      appBar: AppBar(
        title: Text('Create Field'),
      ),
      body: Body(
        fieldId: fieldId,
        clubId: clubId,
        isCreate: isCreate,
      ),
    );
  }
}

class Body extends StatefulWidget {
  final int fieldId;
  final int clubId;
  final bool isCreate;

  const Body({Key key, this.fieldId, this.clubId, this.isCreate})
      : super(key: key);

  @override
  _BodyState createState() => _BodyState(fieldId, clubId, isCreate);
}

class _BodyState extends State<Body> {
  final int clubId;
  final int fieldId;
  final bool isCreate;
  Field field = Field();
  List<Time> times = List<Time>();
  Map<String, dynamic> textCtl;
  var _formKey = GlobalKey<FormState>();

  _BodyState(this.fieldId, this.clubId, this.isCreate);

  @override
  void initState() {
    fetchData();
    Future.delayed(Duration(milliseconds: 200), () => setState(() {}));
    super.initState();
  }

  Future<void> fetchData() async {
    field = (fieldId != null)
        ? await FieldServices.getFieldById(id: fieldId)
        : Field();
  }

  void setDefaultInput() {
    textCtl = {
      'title': TextEditingController(text: field.title),
      'detail': TextEditingController(text: field.detail),
      'price': TextEditingController(text: field.price),
    };
  }

  @override
  Widget build(BuildContext context) {
    setDefaultInput();
    return Container(
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            SizedBox(height: 10),
            OutlineField(
              labelText: 'Title',
              hintText: 'title',
              controller: textCtl['title'],
              onSaved: (input) => field.title = input,
            ),
            SizedBox(height: 10),
            OutlineField(
              labelText: 'Detail',
              hintText: 'detail',
              controller: textCtl['detail'],
              onSaved: (input) => field.detail = input,
            ),
            SizedBox(height: 10),
            OutlineField(
              labelText: 'Price',
              hintText: 'prince',
              controller: textCtl['price'],
              onSaved: (input) => field.price = input,
            ),
            SizedBox(height: 10),
            SizedBox(height: 10),
            RoundedButton(
              text: (isCreate) ? 'Update' : 'Create',
              onTap: () async {
                _formKey.currentState.save();
                field.clubId = clubId;
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
