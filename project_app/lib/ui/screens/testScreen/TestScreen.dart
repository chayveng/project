import 'package:flutter/material.dart';
import 'package:project_app/ui/screens/createClub/create_club.dart';
import 'package:project_app/ui/screens/field/field_screen.dart';
import 'package:project_app/ui/screens/testScreen/chooseGirdImage/choose_grid_image_screen.dart';
import 'package:project_app/ui/screens/testScreen/exampleGetImage/example_get_image.dart';
import 'package:project_app/ui/screens/testScreen/googleMap/google_map_screen.dart';
import 'package:project_app/ui/screens/testScreen/multiPicImages/multi_pic_images_screen.dart';
import 'package:project_app/ui/screens/testScreen/newCreateClubScreen/new_create_club_screen.dart';
import 'package:project_app/ui/screens/testScreen/sectionImagesClub/section_images_screen.dart';
import 'package:project_app/ui/screens/testScreen/testGetImages/test_get_images_screen.dart';
import 'package:project_app/ui/screens/testScreen/testSendValue/test_send_value_screen.dart';
import 'body.dart';

class TestScreen extends StatelessWidget {
  static String routeName = '/test_screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(title: Text('Test')),
      // body: FeedJsonData(),
      // body: CustomTimePicker(),
      // body: CustomAppBarListViewButton(),
      // body: TimeListSection(),
      // body: SizePositionPage(),
      // body: SimpleAnimatedList(),
      // body: SectionGreen(),
      // body: TestAddUserImage(),
      // body: CreateClubScreen(),
      // body: GoogleMapScreen(),
      // body: TestSendValueScreen(),
      // body: MultiPicImagesScreen()
      // body: ChooseGridImageScreen(),
      // body: NewCreateClubScreen(),
      // body: TestGetImagesScreen(),
      // body: ExampleGatImage(),
      // body: SectionImagesClub(),
      body: FieldScreen(),
      // body: Body(),
    );
  }
}
