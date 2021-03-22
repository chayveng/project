import 'package:flutter/material.dart';
import 'package:project_app/core/models/Club.dart';

import '../../../../core/models/Club.dart';
import '../../../../core/services/ClubService.dart';
import '../../../../core/services/ClubService.dart';
import '../../club/club_screen.dart';
import 'card_club.dart';
import 'search_bar.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  List<Club> clubs;
  var _refresh = GlobalKey<RefreshIndicatorState>();

  @override
  void initState() {
    _fetchData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size sized = MediaQuery.of(context).size;
    return Column(
      children: [
        Expanded(
          child: RefreshIndicator(
            key: _refresh,
            child: _listSection(),
            onRefresh: _handleRefresh,
          ),
        ),
      ],
    );
  }

  Widget _listSection() {
    return ListView.builder(
      itemCount: (clubs == null) ? 0 : clubs.length,
      itemBuilder: (context, index) {
        if (index == 0) {
          return Column(
            children: [
              SearchBar(),
              CardClub(
                onTap: () {},
                club: clubs[index],
              ),
            ],
          );
        } else {
          return CardClub(
            onTap: () {
              print("onTap");
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //     builder: (context) => ClubScreen(
              //       club: clubs[index],
              //     ),
              //   ),
              // );
            },
            club: clubs[index],
          );
        }
      },
    );
  }

  Future<Null> _handleRefresh() async {
    _fetchData();
    await Future.delayed(Duration(seconds: 1));
    setState(() {});
    return null;
  }

  Future<void> _fetchData() async {
    clubs = await ClubService.fetchClubs();
    setState(() {});
  }
}
