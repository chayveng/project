import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart';
import 'package:project_app/constants.dart';
import 'package:project_app/core/models/Field.dart';
import 'package:project_app/core/models/Time.dart';
import 'package:project_app/core/services/FieldServices.dart';
import 'package:project_app/core/services/TimeService.dart';
import 'package:project_app/core/services/UserService.dart';
import 'package:project_app/ui/components/custom_widget_loading.dart';
import 'package:project_app/ui/screens/booking/components/alert_dialog_cancel.dart';
import 'package:project_app/ui/screens/booking/components/not_booking.dart';
import 'package:url_launcher/url_launcher.dart';

import 'components/card_info.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  List<Time> times = [];
  List<Time> timesNew = [];
  List<Time> timesAccept = [];
  List<Time> timesNotAccept = [];
  List<Field> fields = [];
  String _launchUrl = 'https://www.google.com';

  sortTime() {
    for (int i = 0; i < times.length; i++) {
      if (times[i].status! == true) {
        timesNew.add(times[i]);
      }
    }
    for (int i = 0; i < times.length; i++) {
      if (times[i].status! == false) {
        timesNew.add(times[i]);
      }
    }
    // setState(() {});
  }

  _onCancel(Time time) async {
    await showDialog(
      context: context,
      builder: (context) => AlertDialogCancel(
        time: time,
        onCancel: () async {
          await TimeService.deleteById(time.id!);
          Navigator.pop(context);
        },
      ),
    ).then((value) => setState(() {}));
  }

  _onMap(int index) async {
    Field field = getField(index);
    if (field.location != null) {
      String location = field.location!;
      LatLng lct = decodeLct(location);
      print(lct);
      await mapLauncher(lct.latitude, lct.longitude);
    } else {
      print('location is null');
    }
  }

  Field getField(int index) {
    int fieldId = times[index].fieldId!;
    Field _field = Field();
    fields.map((e) {
      if (e.id == fieldId) {
        _field = e;
      }
    }).toList();
    return _field;
  }

  Future fetchData() async {
    fields.clear();
    times.clear();
    timesNew.clear();
    int userId = await UserService.getUserId();
    times = await TimeService.findByUserId(userId);
    List<int> fieldIds =
        List.generate(times.length, (index) => times[index].fieldId!)
            .toSet()
            .toList();
    print(fieldIds);
    for (int i = 0; i < fieldIds.length; i++) {
      Field field = Field();
      field = await FieldServices.findById(fieldId: fieldIds[i]);
      fields.add(field);
    }
    sortTime();
    print(fields.length);
    await Future.delayed(Duration(milliseconds: 300));
    return true;
  }

  Widget sectionInfo() {
    return timesNew.length != 0
        ? Container(
            child: Column(
              children: [
                ...List.generate(
                  timesNew.length,
                  (index) => CardInfo(
                    onMap: () async => await _onMap(index),
                    onCancel: () async => _onCancel(timesNew[index]),
                    field: getField(index),
                    time: timesNew[index],
                  ),
                ),
              ],
            ),
          )
        : SizedBox();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: fetchData(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasError) print(snapshot.hasError);
        // if (snapshot.hasData) print(snapshot.data);
        return snapshot.hasData
            ? timesNew.length != 0
                ? SingleChildScrollView(
                    child: Column(
                      children: [
                        sectionInfo(),
                      ],
                    ),
                  )
                : NotBooking()
            : CustomWidgetLoading();
      },
    );
  }
}
