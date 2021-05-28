import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:project_app/core/models/Club.dart';
import 'package:project_app/core/services/ClubService.dart';
import 'package:project_app/ui/screens/testScreen/newCreateClubScreen/components/sectionImags/section_images.dart';

import 'components/sectionField/section_field.dart';

class Body extends StatefulWidget {
  final int clubId;
  final bool isCreate;

  const Body({Key key, this.clubId, this.isCreate}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  Club club = Club();
  List<Uint8List> images = [];

  @override
  void initState() {
    fetchData();
    super.initState();
  }

  Future<void> onSubmit() async {
    print('on submit');
    print(images.length);
    print(club);
  }

  void fetchData() async {
    print('clubId: ${widget.clubId}');
    club = widget.clubId != null
        ? await ClubService.getById(id: widget.clubId)
        : Club();
    await Future.delayed(Duration(milliseconds: 200), () => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
        child: Column(
          children: [
            // SizedBox(height: 30),
            SectionImagestest(images: images),
            SectionField(
              club: club,
              isCreate: false,
              onSubmit: () async => await onSubmit(),
            ),
          ],
        ),
      ),
    );
  }
}
