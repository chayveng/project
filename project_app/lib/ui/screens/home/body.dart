import 'package:flutter/material.dart';
import 'package:project_app/core/models/Field.dart';
import 'package:project_app/core/services/FieldServices.dart';
import 'package:project_app/ui/components/custom_widget_loading.dart';

import 'components/section_fields.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  List<Field> fields = [];
  var _refresh = GlobalKey<RefreshIndicatorState>();
  // @override
  // void initState() {
  //   fetchData();
  //   super.initState();
  // }
  //
  // Future<Null> _handleRefresh() async {
  //   fetchData();
  //   await Future.delayed(Duration(milliseconds: 100), () => setState(() {}));
  //   return null;
  // }
  //
  // Future<bool> refresh() async {
  //   await Future.delayed(Duration(milliseconds: 200));
  //   return true;
  // }
  //
  // Future<bool> fetchData() async {
  //   fields = [];
  //   fields = await FieldServices.findAll();
  //   await Future.delayed(Duration(milliseconds: 100), () => setState(() {}));
  //   return true;
  // }
  //
  // List<Field> fields = [];
  // var _refresh = GlobalKey<RefreshIndicatorState>();
  //
  // // Future refresh() async {
  // //   print('refresh');
  // //   await Future.delayed(
  // //     Duration(milliseconds: 5000),
  // //     () async => await fetchData(),
  // //   );
  // // }
  //
  // Future setData() async {
  //   fields = [];
  //   fields = await FieldServices.findAll();
  //   await Future.delayed(Duration(milliseconds: 2000));
  //   setState(() {});
  // }
  //
  // Future<bool?> fetchData() async {
  //   print('fetchData');
  //   setData();
  //   if (fields.length == 0) {
  //     setData();
  //     print(fields.length);
  //     print(false);
  //     return false;
  //   } else {
  //     print(fields.length);
  //     print(true);
  //     return true;
  //   }
  // }

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
    print(fields.length);
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: true,
      child: SingleChildScrollView(
        child: Column(
          children: [
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
      ),
    );
  }
}
