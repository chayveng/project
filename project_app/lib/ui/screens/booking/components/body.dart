import 'package:flutter/material.dart';
import 'package:project_app/core/models/Club.dart';
import 'package:project_app/core/models/Field.dart';
import 'package:project_app/core/models/Time.dart';
import 'package:project_app/core/services/ClubService.dart';
import 'package:project_app/core/services/FieldServices.dart';
import 'package:project_app/core/services/TimeService.dart';
import 'package:project_app/core/services/UserService.dart';
import 'package:project_app/ui/screens/booking/components/not_booking.dart';
import 'package:project_app/ui/screens/booking/components/section_club.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  List<Club> clubs = new List<Club>();
  List<Field> fields = new List<Field>();
  List<Time> times = new List<Time>();

  @override
  void initState() {
    fetchData();
    super.initState();
  }

  fetchData() async {
    await fetchTimes();
    await fetchFields();
    await fetchClubs();
    await Future.delayed(Duration(milliseconds: 100), () => setState(() {}));
  }

  Future<void> fetchClubs() async {
    clubs = [];
    List clubsId = [];
    fields.map((e) => clubsId.add(e.userId)).toList();
    clubsId = clubsId.toSet().toList();
    for (var i = 0; i < clubsId.length; i++) {
      clubs.add(await ClubService.getById(id: clubsId[i]));
    }
  }

  Future<void> fetchFields() async {
    fields = [];
    List fieldsId = [];
    times.map((e) => fieldsId.add(e.fieldId)).toList();
    fieldsId = fieldsId.toSet().toList();
    for (var i = 0; i < fieldsId.length; i++) {
      // fields.add(await FieldServices.getFieldById(id: fieldsId[i]));
    }
  }

  Future<void> fetchTimes() async {
    int userId = await UserService.getUserId();
    times = await TimeService.getByUserId(userId: userId);
    times.map((e) => print(e.fieldId));
  }

  @override
  Widget build(BuildContext context) {
    return times.length == 0
        ? NotBooking()
        : SingleChildScrollView(
            child: Column(
              children: [
                Center(
                  child: SectionClub(
                    clubs: clubs,
                    fields: fields,
                    times: times,
                  ),
                ),
              ],
            ),
          );
  }
}
