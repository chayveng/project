import 'package:flutter/material.dart';
import 'package:project_app/core/models/Club.dart';

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
    _fetchData();
    Future.delayed(Duration(milliseconds: 500), () => setState(() {}));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: RefreshIndicator(
            key: _refresh,
            child: ListSection(clubs: clubs),
            onRefresh: _handleRefresh,
          ),
        ),
      ],
    );
  }

  Future<Null> _handleRefresh() async {
    _fetchData();
    await Future.delayed(Duration(milliseconds: 1000));
    setState(() {});
    return null;
  }

  Future<void> _fetchData() async {
    clubs = await ClubService.fetchClubs();
    clubs = clubs ?? List<Club>();
    // print("fetchData: $clubs");
    // await Future.delayed(Duration(milliseconds: 500));
    // setState(() {});
  }
}
