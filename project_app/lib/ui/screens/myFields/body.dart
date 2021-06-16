import 'package:flutter/material.dart';
import 'package:project_app/core/apis/FieldApi.dart';
import 'package:project_app/core/models/Field.dart';
import 'package:project_app/core/services/FieldServices.dart';
import 'package:project_app/core/services/UserService.dart';
import 'package:project_app/ui/components/card_field.dart';
import 'package:project_app/ui/components/custom_alert_dialog.dart';
import 'package:project_app/ui/components/custom_dialog_loading.dart';
import 'package:project_app/ui/screens/createField/create_field_screen.dart';
import 'package:project_app/ui/screens/field/field_screen.dart';
import 'package:project_app/ui/screens/myFields/components/custom_appbar.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  var _refresh = GlobalKey<RefreshIndicatorState>();
  List<Field> fields = [];

  @override
  void initState() {
    // fetchData();
    super.initState();
  }

  Future<void> backWord() async {
    await fetchData();
    await Future.delayed(Duration(milliseconds: 300), () => setState(() {}));
  }

  Future _remove(int fieldId) async {
    var res = await FieldApi.delete(fieldId);
    if (res.status == 1) {
      await fetchData();
      Navigator.pop(context);
    } else {
      print("delete error");
    }
  }

  Future _onRemove(int fieldId) async {
    showDialog(
      context: context,
      builder: (context) => CustomAlertDialog(
        title: 'Remove',
        content: 'Confirm remove ?',
        onConfirm: () => _remove(fieldId),
        onCancel: () => Navigator.pop(context),
      ),
    );
  }

  Future onCreate() async {
    await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CreateFieldScreen(isCreate: true),
          ),
        ) ??
        backWord();
  }

  Future<bool> fetchData() async {
    fields = await FieldServices.getByUserId(await UserService.getUserId());
    await Future.delayed(Duration(milliseconds: 300));
    // await Future.delayed(Duration(milliseconds: 100), () => setState(() {}));
    print('fetchData');
    return true;
  }

  void _onTap(int index) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FieldScreen(
          isOwner: true,
          fieldId: fields[index].id,
        ),
      ),
    );
  }

  Widget buildListFields(List fields) {
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          children: [
            ...List.generate(
              fields.length,
              (index) => Padding(
                padding: const EdgeInsets.only(left: 8, top: 18, right: 8),
                child: CardField(
                  isOwner: true,
                  field: fields[index],
                  onTap: () => _onTap(index),
                  onRemove: () => _onRemove(fields[index].id),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildBody() {
    return Column(
      children: [
        CustomAppbar(onPressed: onCreate),
        buildListFields(fields),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: fetchData(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          return buildBody();
        } else {
          return CustomDialogLoading();
        }
      },
    );
  }
}
