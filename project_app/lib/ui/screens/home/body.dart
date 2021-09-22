import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:project_app/core/models/Field.dart';
import 'package:project_app/core/services/FieldServices.dart';
import 'package:project_app/ui/components/card_field.dart';
import 'package:project_app/ui/components/custom_widget_loading.dart';
import 'package:project_app/ui/screens/home/components/custom_search_bar.dart';

import '../../../constants.dart';
import 'components/search_engine.dart';
import 'components/section_fields.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  List<Field> fields = [];
  LatLng? currentLct;

  @override
  void initState() {
    // fetchData();
    getCurrentLct();
    super.initState();
  }

  Future getCurrentLct() async {
    Location location = Location();
    LocationData lctData = await location.getLocation();
    currentLct = LatLng(lctData.latitude!, lctData.longitude!);
    print(currentLct);
  }

  Future<bool> _refreshData(BuildContext context) async {
    await fetchData();
    return true;
  }

  Future<bool> fetchData() async {
    fields = [];
    fields = await FieldServices.findAll();
    // print(fields.length);
    await Future.delayed(Duration(milliseconds: 500));
    return true;
  }

  @override
  Widget build(BuildContext context) {
    // return Column(
    //   children: [
    //     ...List.generate(
    //       fields.length,
    //       (index) => Text('${fields[index].title}'),
    //     ),
    //   ],
    // );
    return RefreshIndicator(
    color: orangePrimaryColor,
    onRefresh: () async => await _refreshData(context),
    child: FutureBuilder(
      future: fetchData(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasError) print(snapshot.hasError);
        if (snapshot.hasData) print(snapshot.data);
        return snapshot.hasData
            ? SectionFields(fields: fields, currentLct: currentLct  )
            : CustomWidgetLoading();
      },
    ),
    );
  }
}
