import 'package:flutter/material.dart';
import 'package:project_app/core/models/Club.dart';
import 'package:project_app/core/models/Field.dart';
import 'package:project_app/core/services/FieldServices.dart';
import 'package:project_app/ui/components/get_image_network.dart';
import 'package:project_app/ui/components/rounded_button.dart';
import 'package:project_app/ui/screens/club/components/card_field.dart';
import 'package:project_app/ui/screens/createClub/create_club.dart';

import '../../../../constants.dart';
import 'custom_top_bar.dart';

class Body extends StatefulWidget {
  final Club club;
  final bool isOwner;

  Body({Key key, this.club, this.isOwner}) : super(key: key);

  @override
  _BodyState createState() => _BodyState(club, isOwner);
}

class _BodyState extends State<Body> {
  final Club club;
  final bool isOwner;
  List<Field> fields = new List<Field>();

  _BodyState(this.club, this.isOwner);

  @override
  void initState() {
    fetchFields();
    super.initState();
  }

  Future<void> fetchFields() async {
    await Future.delayed(Duration(milliseconds: 500));
    fields = await FieldServices.fetchFieldClubId(club.id);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Container(
                width: sized(context).width,
                height: sized(context).height * 0.4,
                child: GetImageNetwork(
                  landscape: true,
                  photosPath: club.photosPath,
                ),
              ),
              CustomTopBar(
                isOwner: isOwner,
                title: club.title,
                trailingTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          CreateClub(club: club, isOwner: true),
                    ),
                  );
                },
              ),
            ],
          ),
          ...List.generate(
            (fields == null) ? 0 : fields.length,
            (index) {
              return CardField(
                field: fields[index],
              );
            },
          ),
          SizedBox(height: 10),
          SizedBox(
            child: isOwner == true
                ? RoundedButton(
                    text: 'Add Field',
                    onTap: () {},
                  )
                : SizedBox(),
          ),
        ],
      ),
    );
  }
}
