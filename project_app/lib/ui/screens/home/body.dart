import 'package:flutter/material.dart';
import 'package:project_app/core/models/Field.dart';
import 'package:project_app/core/services/FieldServices.dart';
import 'package:project_app/ui/components/custom_widget_loading.dart';

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
    print('Fields: ${fields.length}');
    return true;
  }

  List<String> list = List.generate(100, (index) => '$index');

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            color: Colors.yellow,
            child: AppBar(
              backgroundColor: whiteColor,
              title: Text('หน้าหลัก'),
              centerTitle: true,
              actions: [
                IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    print('search');
                    showSearch(context: context, delegate: Search(fields));
                  },
                ),
              ],
            ),
          ),

          Container(
            height: sized(context).height,
            child: SectionFields(fields: fields),
          ),
          // RefreshIndicator(
          //   key: _refresh,
          //   onRefresh: _handleRefresh,
          //   child: FutureBuilder(
          //     future: refresh(),
          //     builder: (BuildContext context, AsyncSnapshot snapshot) {
          //       // return Container(
          //       //   height: sized(context).height,
          //       //   child: ListView.builder(
          //       //     itemCount: list.length,
          //       //     itemBuilder: (context, index) => ListTile(
          //       //       title: Text(list[index]),
          //       //     ),
          //       //   ),
          //       // );
          //       if (fields.isNotEmpty) {
          //         // return Text('dddd');
          //         // return SectionFields(fields: fields);
          //       } else {
          //         return CustomWidgetLoading();
          //       }
          //     },
          //   ),
          // ),
        ],
      ),
    );
  }
}
