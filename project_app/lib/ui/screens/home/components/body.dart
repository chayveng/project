import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:project_app/core/models/Club.dart';

import '../../../../constants.dart';
import '../../../../core/models/Club.dart';
import '../../../../core/services/ClubService.dart';
import 'list_section.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  List<Club> clubs = List<Club>();
  var _refresh = GlobalKey<RefreshIndicatorState>();

  @override
  void initState() {
    fetchData();
    super.initState();
  }

  Future<Null> _handleRefresh() async {
    fetchData();
    await Future.delayed(Duration(milliseconds: 100),()=> setState((){}));
    return null;
  }

  Future<bool> fetchData() async {
    clubs = await ClubService.getClubs();
    clubs = clubs ?? List<Club>();
    await Future.delayed(Duration(milliseconds: 100),() => setState((){}));
    return true;
  }

  Expanded listClub() {
    return Expanded(
      child: RefreshIndicator(
        key: _refresh,
        child: FutureBuilder(
          future: fetchData(),
          builder: (BuildContext context, AsyncSnapshot snapshot) =>
              (snapshot.hasData) ? ListSection(clubs: clubs) : waitLoading(),
        ),
        onRefresh: _handleRefresh,
      ),
    );
  }

  Center waitLoading() {
    return Center(
      child: SpinKitWave(
        color: orangePrimaryColor,
        size: 40,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        listClub(),
      ],
    );
  }
}
