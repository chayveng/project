import 'package:flutter/material.dart';
import 'package:project_app/core/models/Club.dart';
import 'package:project_app/core/services/ClubService.dart';
import 'package:project_app/ui/screens/home/components/card_club.dart';

class FeedJsonData extends StatefulWidget {
  @override
  _FeedJsonDataState createState() => _FeedJsonDataState();
}

class _FeedJsonDataState extends State<FeedJsonData> {
  final GlobalKey<RefreshIndicatorState> _refresh =
      GlobalKey<RefreshIndicatorState>();

  @override
  Widget build(BuildContext context) {
    Size sized = MediaQuery.of(context).size;
    return Column(
      children: [
        Expanded(
          child: Container(
            height: sized.height,
            child: Center(
              child: FutureBuilder<List<Club>>(
                future: ClubService.getClubs(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Container(
                      child: RefreshIndicator(
                        key: _refresh,
                        child: _listSection(clubs: snapshot.data),
                        onRefresh: _handleRefresh,
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return Text('${snapshot.error}');
                  }
                  return CircularProgressIndicator();
                },
              ),
            ),
          ),
        ),
      ],
    );
  }

  Future<Null> _handleRefresh() async {
    await Future.delayed(Duration(seconds: 1));
    setState(() {});
    return null;
  }

  Widget _listSection({List<Club> clubs}) => ListView.builder(
        itemCount: clubs.length,
        itemBuilder: (context, index) {
          return CardClub(
            club: clubs[index],
            onTap: () {},
          );
        },
      );
}
