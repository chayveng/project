import 'package:flutter/material.dart';
import 'package:project_app/core/models/Club.dart';
import 'package:project_app/core/models/Field.dart';
import 'package:project_app/core/models/Time.dart';
import 'package:project_app/ui/components/get_image_network.dart';
import 'package:project_app/ui/screens/booking/components/section_field.dart';

import '../../../../constants.dart';

class SectionClub extends StatelessWidget {
  final List<Club> clubs;
  final List<Field> fields;
  final List<Time> times;

  const SectionClub({
    Key key,
    @required this.clubs,
    @required this.fields,
    @required this.times,
  }) : super(key: key);

  Widget sectionImage(BuildContext context) {
    return Container(
      width: sized(context).width,
      height: 200,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(10),
          topLeft: Radius.circular(10),
        ),
        color: Colors.redAccent,
      ),
    );
  }

  Widget cardClub(BuildContext context, int indexClub) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0,right: 8, top: 8),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Material(
          color: orangePrimaryColor.withOpacity(0.3),
          child: Column(
            children: [
              imageBox(context: context,photoPath: clubs[indexClub].photosPath),
              SizedBox(height: 10),
              Row(
                children: [
                  SizedBox(width: 10),
                  Text(
                    clubs[indexClub].title,
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: navyPrimaryColor
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SectionField(
                  clubId: clubs[indexClub].id,
                  fields: fields,
                  times: times,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget imageBox({@required BuildContext context,@required String photoPath}) {
    return Container(
      width: sized(context).width,
      height: sized(context).height * 0.3,
      child: GetImageNetwork(
        landscape: true,
        photosPath: photoPath,
      ),
    );
  }

  Widget listSection(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          ...List.generate(
            clubs.length ?? 0,
            (indexClub) => cardClub(context, indexClub),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return listSection(context);
  }
}
