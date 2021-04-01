import 'package:flutter/material.dart';
import 'package:project_app/core/models/Club.dart';
import 'package:project_app/ui/components/get_image_network.dart';
import 'package:project_app/ui/screens/club/components/sectionImage/top_bar.dart';
import 'package:project_app/ui/screens/createClub/create_club.dart';

import '../../../../../constants.dart';

class SectionImage extends StatefulWidget {
  final bool isOwner;
  final Club club;

  const SectionImage({
    Key key,
    this.isOwner,
    this.club,
  }) : super(key: key);

  @override
  _SectionImageState createState() => _SectionImageState(isOwner,club);
}

class _SectionImageState extends State<SectionImage> {
  final bool isOwner;
  final Club club;

  _SectionImageState(
    this.isOwner,
    this.club,
  );

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: sized(context).width,
          height: sized(context).height * 0.4,
          child: GetImageNetwork(
            landscape: true,
            photosPath: club.photosPath,
          ),
        ),
        TopBar(
          isOwner: isOwner,
          title: club.title,
          // editTap: editTap,
          editTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CreateClub(
                  club: club,
                  isOwner: true,
                  isCreate: true,
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
