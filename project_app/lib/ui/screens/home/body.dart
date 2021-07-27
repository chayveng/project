import 'package:flutter/material.dart';
import 'package:project_app/core/models/Field.dart';
import 'package:project_app/core/services/FieldServices.dart';
import 'package:project_app/ui/components/card_field.dart';
import 'package:project_app/ui/components/custom_widget_loading.dart';
import 'package:project_app/ui/screens/home/components/custom_search_bar.dart';

import '../../../constants.dart';
import 'components/search_engine.dart';
import 'components/section_fields.dart';

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
    setState(() {});
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
    // print('Fields: ${fields.length}');
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          CustomSearchBar(fields: fields),
          RefreshIndicator(
            key: _refresh,
            onRefresh: _handleRefresh,
            child: FutureBuilder(
              future: refresh(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (fields.isNotEmpty) {
                  return SectionFields(fields: fields);
                } else {
                  return CustomWidgetLoading();
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
