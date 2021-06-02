import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;
import 'package:project_app/config/Config.dart';
import 'package:project_app/core/models/ApiResponse.dart';
import 'package:project_app/core/models/Field.dart';
import 'package:project_app/core/services/FieldServices.dart';
import 'package:project_app/core/services/UserService.dart';
import 'package:project_app/ui/components/card_field.dart';
import 'package:project_app/ui/screens/field/create/create_field_screen.dart';
import 'package:project_app/ui/screens/field/field_screen.dart';

import '../../../constants.dart';
// import 'components/card_field.dart';

class Body extends StatefulWidget {
  const Body({Key key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  var _refresh = GlobalKey<RefreshIndicatorState>();
  List<Field> fields = [];

  @override
  void initState() {
    fetchData();
    super.initState();
  }

  Future<bool> fetchData() async {
    fields = await FieldServices.getByUserId();
    await Future.delayed(Duration(milliseconds: 100), () => setState(() {}));
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
    return Column(
      children: [
        ...List.generate(
          fields.length,
          (index) => Padding(
            padding: const EdgeInsets.only(left: 8, top: 8, right: 8),
            child: CardField(
              field: fields[index],
              onTap: () => _onTap(index),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          AppBar(
            excludeHeaderSemantics: false,
            primary: true,
            title: Text('My Fields'),
            actions: [
              IconButton(
                icon: Icon(Icons.add),
                onPressed: () async {
                  await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              CreateFieldScreen(isCreate: true),
                        ),
                      ) ??
                      fetchData();
                },
              ),
            ],
          ),
          buildListFields(fields),
        ],
      ),
    );
  }
}
