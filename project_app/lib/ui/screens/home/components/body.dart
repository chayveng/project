import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:project_app/core/models/Club.dart';
import 'package:project_app/ui/screens/club/club_screen.dart';
import 'package:project_app/ui/screens/home/components/search_bar.dart';

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
    clubs = _setClub(index: 5);
    super.initState();
  }

  List<Club> _setClub({int index}) => List.generate(
        index,
        (index) => new Club(
          id: index,
          userId: index,
          title: 'Club:$index',
          detail: 'detail:$index',
          map: 'map:$index',
          tel: 'tel:$index',
          price: 'price:$index',
          photosPath: 'assets/images/clubs/club-${index + 1}.jpg',
        ),
      );

  @override
  Widget build(BuildContext context) {
    Size sized = MediaQuery.of(context).size;
    return RefreshIndicator(
      key: _refresh,
      child: SingleChildScrollView(
        child: Column(
          children: [
            SafeArea(child: SizedBox()),
            SearchBar(),
            ..._listSection(),
          ],
        ),
      ),
      onRefresh: _handleRefresh,
    );
  }

  List<Widget> _listSection() {
    return List.generate(
      clubs.length,
      (index) => CardClub(
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
        club: clubs[index],
        onPressed: () {
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
