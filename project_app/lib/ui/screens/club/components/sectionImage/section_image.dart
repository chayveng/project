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
  _SectionImageState createState() => _SectionImageState();
}

class _SectionImageState extends State<SectionImage> {
  void _onEdit({@required BuildContext context}) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CreateClub(
          club: widget.club,
          isOwner: true,
          isCreate: true,
        ),
      ),
    );
  }

  Widget topBar({@required BuildContext context}) {
    return TopBar(
      isOwner: widget.isOwner,
      title: widget.club.title,
      onEdit: () => _onEdit(context: context),
    );
  }

  Widget imageBox({@required BuildContext context}) {
    return Container(
      width: sized(context).width,
      height: sized(context).height * 0.4,
      child: GetImageNetwork(
        landscape: true,
        photosPath: widget.club.photosPath,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        imageBox(context: context),
        topBar(context: context),
      ],
    );
  }
}
