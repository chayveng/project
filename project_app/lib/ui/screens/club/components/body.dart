import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:project_app/core/models/Club.dart';
import 'package:project_app/core/models/Field.dart';
import 'package:project_app/core/models/Time.dart';
import 'package:project_app/core/services/ClubService.dart';
import 'package:project_app/ui/screens/club/components/sectionField/section_field.dart';
import 'package:project_app/ui/screens/club/components/sectionImage/section_image.dart';

import '../../../../constants.dart';

class Body extends StatefulWidget {
  final int clubId;
  final bool isOwner;

  Body({Key key, this.clubId, this.isOwner}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  Club club = new Club();
  List<Field> fields = new List<Field>();
  List<Time> times = new List<Time>();

  @override
  void initState() {
    fetchData();
    super.initState();
  }

  Future<bool> fetchData() async {
    club = await ClubService.getById(id: widget.clubId);
    await Future.delayed(Duration(milliseconds: 500), () => setState(() {}));
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: fetchData(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SectionImage(isOwner: widget.isOwner, club: club),
                SectionField(clubId: widget.clubId, isOwner: widget.isOwner),
              ],
            ),
          );
        } else {
          return SpinKitWave(color: orangePrimaryColor, size: 40);
        }
      },
    );
  }
}