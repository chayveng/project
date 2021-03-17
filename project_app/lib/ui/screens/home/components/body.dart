import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:project_app/core/models/Club.dart';
import 'package:project_app/ui/screens/club/club_screen.dart';

import 'card_club.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  List<Club> clubs;
  var _refresh = GlobalKey<RefreshIndicatorState>();

  @override
  void initState() {
    clubs = _setClub(index: 10);
    super.initState();
  }

  List<Club> _setClub({int index}) => List.generate(
        index,
        (index) => new Club(
          id: index,
          userId: index,
          title: 'Club:$index',
          detail: 'detail:$index',
          googleMap: 'map:$index',
          tel: 'tel:$index',
          photoPath: 'assets/images/clubs/club-${index+1}.jpg',
        ),
      );

  @override
  Widget build(BuildContext context) {
    Size sized = MediaQuery.of(context).size;
    return SafeArea(
      child: Column(
        children: [
          Expanded(
            child: RefreshIndicator(
              key: _refresh,
              child: _listSection(),
              onRefresh: _handleRefresh,
            ),
          ),
        ],
      ),
    );
  }

  ListView _listSection() {
    return ListView.builder(
      itemCount: clubs.length,
      itemBuilder: (context, index) => CardClub(
        club: clubs[index],
        onTap: () {
          Navigator.push(
            context,
            PageTransition(
              type: PageTransitionType.fade,
              child: ClubScreen(
                club: clubs[index],
              ),
            ),
          );
        },
      ),
    );
  }

  Future<Null> _handleRefresh() async {
    await Future.delayed(Duration(seconds: 1));
    setState(() {});
    return null;
  }
}
