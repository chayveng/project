import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:project_app/core/models/Field.dart';
import 'package:project_app/core/models/Time.dart';
import 'package:project_app/core/services/FieldServices.dart';
import 'package:project_app/core/services/TimeService.dart';
import 'package:project_app/core/services/UserService.dart';
import 'package:project_app/ui/screens/booking/components/not_booking.dart';

import 'components/card_info.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  List<Time> times = [];
  List<Field> fields = [];

  @override
  void initState() {
    fetchData();
    super.initState();
  }

  _onMap() {
    print('go to map');
  }

  Future<void> fetchData() async {
    fields.clear();
    int userId = await UserService.getUserId();
    times = await TimeService.findByUserId(userId);
    List<int> fieldIds =
    List.generate(times.length, (index) => times[index].fieldId!)
        .toSet()
        .toList();
    fieldIds
        .map((e) async => fields.add(await FieldServices.findById(fieldId: e)))
        .toList();
    await Future.delayed(Duration(milliseconds: 300), () => setState(() {}));
    // print(times.length);
    // print(fields.length);
  }

  Field getFieldById(int fieldId) {
    Field _field = Field();
    fields.map((e) {
      if (e.id == fieldId) {
        _field = e;
      }
    }).toList();
    return  _field;
  }

  Widget sectionInfo() {
    return times.length != 0
        ? Container(
      child: Column(
        children: [
          ...List.generate(
            times.length,
                (index) =>
                CardInfo(
                  field: getFieldById(times[index].fieldId!),
                  time: times[index],
                  onMap: _onMap,
                ),
          ),
        ],
      ),
    )
        : SizedBox();
  }

  @override
  Widget build(BuildContext context) {
    return times.length != 0 ? Column(
      children: [
        sectionInfo(),
        Center(child: Text('Booking')),
        ElevatedButton(
          // onPressed: () => fetchData(),
          onPressed: () => getFieldById(1),
          child: Text(''),
        ),
      ],
    ): NotBooking();
  }
}
