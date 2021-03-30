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
    _fetchData();
    super.initState();
  }

  Future<Null> _handleRefresh() async {
    _fetchData();
    await Future.delayed(Duration(milliseconds: 500));
    setState(() {});
    return null;
  }

  Future<bool> _fetchData() async {
    clubs = await ClubService.fetchClubs();
    clubs = clubs ?? List<Club>();
    await Future.delayed(Duration(milliseconds: 500));
    // await Future.delayed(Duration(milliseconds: 500), () => setState(() {}));
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: RefreshIndicator(
            key: _refresh,
            child: FutureBuilder(
              future: _fetchData(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  return ListSection(clubs: clubs);
                } else {
                  return Center(
                    child: SpinKitWave(
                      color: orangePrimaryColor,
                      size: 40,
                    ),
                  );
                }
              },
            ),
            onRefresh: _handleRefresh,
          ),
        ),
      ],
    );
  }

}
