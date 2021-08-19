import 'package:flutter/material.dart';
import 'package:project_app/constants.dart';
import 'package:project_app/core/apis/ApiConnect.dart';
import 'package:project_app/core/apis/FieldApi.dart';
import 'package:project_app/core/models/Field.dart';
import 'package:project_app/core/services/FieldServices.dart';
import 'package:project_app/core/services/UserService.dart';
import 'package:project_app/ui/components/card_field.dart';
import 'package:project_app/ui/components/custom_alert_dialog.dart';
import 'package:project_app/ui/components/custom_dialog_loading.dart';
import 'package:project_app/ui/screens/createField/create_field_screen.dart';
import 'package:project_app/ui/screens/field/field_screen.dart';
import 'package:project_app/ui/screens/myFields/components/alert_dialog_confirm.dart';
import 'package:project_app/ui/screens/myFields/components/custom_appbar.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  var _refresh = GlobalKey<RefreshIndicatorState>();
  List<Field> fields = [];

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

  Future _onRemove(int fieldId, String fieldName) async {
    var res = await showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => AlertDialogConfirm(
        fieldName: fieldName,
        onConfirm: () async {
          if (await FieldServices.deleteById(fieldId)) {
            Navigator.pop(context, true);
          } else {
            print('delete error');
            Navigator.pop(context, false);
          }
        },
      ),
    );
    if (res) backWord();

    // await showDialog(
    //       context: context,
    //       builder: (context) => CustomAlertDialog(
    //         title: 'Remove',
    //         content: 'Confirm remove ?',
    //         onConfirm: () => _remove(fieldId),
    //         onCancel: () => Navigator.pop(context),
    //       ),
    //     ) ??
    // fetchData();
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

  Widget buildBottomSpace(int index) {
    return index == fields.length - 1
        ? SafeArea(top: false, bottom: true, child: SizedBox())
        : SizedBox();
  }

  Widget buildEmpty() {
    return Expanded(
      child: Container(
        child: Center(
          child: Text('Empty'),
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
                padding: EdgeInsets.only(top: 8, left: 8, right: 8),
                child: Column(
                  children: [
                    CardField(
                      isOwner: true,
                      field: fields[index],
                      onTap: () => _onTap(index),
                      onRemove: () =>
                          _onRemove(fields[index].id, fields[index].title),
                    ),
                    buildBottomSpace(index),
                  ],
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
        fields.length != 0 ? buildListFields(fields) : buildEmpty(),
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
