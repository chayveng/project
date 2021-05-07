import 'package:flutter/material.dart';
import 'package:project_app/constants.dart';
import 'package:project_app/core/models/Club.dart';
import 'package:project_app/core/services/ClubService.dart';
import 'package:project_app/ui/screens/testScreen/createClub/create_club_screen.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  Club club = Club();
  int userId = 101;
  bool isCreate = false;

  @override
  void initState() {
    fetchData();
    super.initState();
  }

  void fetchData() async {
    // int userId = await UserService.getUserId();
    club = await ClubService.getByUserId(userId: userId);
    club.id != null ? isCreate = true : isCreate = false;
    print(isCreate);
    await Future.delayed(Duration(microseconds: 500), () => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: sized(context).width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          isCreate
              ? Column(
                  children: [
                    Text(club.title ?? 'null'),
                    Text(club.detail ?? 'null'),
                    Text(club.tel ?? 'null'),
                  ],
                )
              : SizedBox(),
          ElevatedButton(
            child: Text(isCreate ? 'Update ' : 'Create'),
            onPressed: () async {
              await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CreateClubScreen(
                        isCreate: isCreate,
                      ),
                    ),
                  ) ??
                  fetchData();
            },
          ),
          ElevatedButton(
            onPressed: () {
              fetchData();
            },
            child: Text('fetchData'),
          ),
        ],
      ),
    );
  }
}
