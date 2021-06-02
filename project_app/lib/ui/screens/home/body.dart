import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:project_app/core/models/Field.dart';
import 'package:project_app/core/services/FieldServices.dart';
import 'package:project_app/ui/components/card_field.dart';
import 'package:project_app/ui/screens/field/field_screen.dart';

import '../../../constants.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  List<Field> fields = [];
  var _refresh = GlobalKey<RefreshIndicatorState>();

  @override
  void initState() {
    fetchData();
    super.initState();
  }

  Future<Null> _handleRefresh() async {
    fetchData();
    await Future.delayed(Duration(milliseconds: 100), () => setState(() {}));
    return null;
  }

  Future<bool> refresh() async {
    await Future.delayed(Duration(milliseconds: 200));
    return true;
  }

  Future<bool> fetchData() async {
    fields = [];
    fields = await FieldServices.findAll();
    await Future.delayed(Duration(milliseconds: 100), () => setState(() {}));
    return true;
  }

  Center waitLoading() {
    return Center(
      child: SpinKitWave(
        color: orangePrimaryColor,
        size: 40,
      ),
    );
  }

  Widget listField() {
    return RefreshIndicator(
      key: _refresh,
      child: FutureBuilder(
        future: refresh(),
        builder: (BuildContext context, AsyncSnapshot snapshot) =>
            (snapshot.hasData) ? Padding(
              padding: const EdgeInsets.all(8.0),
              child: sectionFields(),
            ) : waitLoading(),
      ),
      onRefresh: _handleRefresh,
    );
  }

  Widget sectionFields() {
    return SingleChildScrollView(
      child: Column(
        children: [
          ...List.generate(
            fields.length,
            (index) => CardField(
              field: fields[index],
              onTap: () {
                print('onTap');
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => FieldScreen(
                      isOwner: false,
                      fieldId: fields[index].id,
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        listField(),
      ],
    );
  }
}
