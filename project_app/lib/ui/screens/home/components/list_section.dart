import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:project_app/core/models/Club.dart';
import 'package:project_app/ui/screens/club/club_screen.dart';
import 'package:project_app/ui/screens/home/components/search_bar.dart';

import 'card_club.dart';

class ListSection extends StatelessWidget {
  const ListSection({
    Key key,
    @required this.clubs,
  }) : super(key: key);

  final List<Club> clubs;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: (clubs != null) ? clubs.length : 0,
      itemBuilder: (context, index) {
        if(clubs == null){
          return SizedBox();
        }else{
          if (index == 0) {
            return Column(
              children: [
                SafeArea(child: SizedBox()),
                SizedBox(height: 8),
                SearchBar(),
                buildCardClub(clubs[index], context),
              ],
            );
          } else {
            return buildCardClub(clubs[index], context);
          }
        }
      },
    );
  }

  CardClub buildCardClub(Club club, BuildContext context) {
    return CardClub(
      onTap: () {
        print("Go to club screen");
        Navigator.push(
          context,
          PageTransition(
            child: ClubScreen(clubId: club.id ,isOwner: false,),
            type: PageTransitionType.fade,
          ),
        );
      },
      club: club,
    );
  }
}
