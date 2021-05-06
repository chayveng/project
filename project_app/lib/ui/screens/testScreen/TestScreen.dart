import 'package:flutter/material.dart';
import 'package:project_app/ui/screens/createClub/create_club.dart';
import 'package:project_app/ui/screens/testScreen/googleMap/google_map_screen.dart';
import 'body.dart';

class TestScreen extends StatelessWidget {
  static String routeName = '/test_screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // body: FeedJsonData(),
      // body: CustomTimePicker(),
      // body: CustomAppBarListViewButton(),
      // body: TimeListSection(),
      // body: SizePositionPage(),
      // body: SimpleAnimatedList(),
      // body: SectionGreen(),
      // body: TestAddUserImage(),
      // body: CreateClubScreen(),
      body: GoogleMapScreen(),
      // body: Body(),
    );
  }
}
