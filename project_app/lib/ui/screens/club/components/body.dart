import 'package:flutter/material.dart';
import 'package:project_app/config/Config.dart';
import 'package:project_app/core/models/Club.dart';
import 'package:project_app/core/models/Field.dart';
import 'package:project_app/core/services/ClubService.dart';
import 'package:project_app/ui/screens/club/components/card_field.dart';
import 'package:project_app/ui/screens/field/field_screen.dart';

import '../../../../constants.dart';

class Body extends StatelessWidget {
  final Club club;

  Body({Key key, this.club}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Field> fields = List.generate(
      3,
      (index) => new Field(
        id: index,
        clubId: club.id,
        title: 'Field:$index',
      ),
    );
    Size sized = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            height: 250,
            width: sized.width,
            child: FadeInImage.assetNetwork(
              placeholder: defaultImage,
              image: ClubService.mainImage(fileName: club.photosPath),
              // image: "${Config.API_URL}/club/images?imageName=${club.photosPath}",
              fit: BoxFit.cover,
            ),
            // child: FlutterLogo(),
          ),
          // Container(
          //   width: sized.width,
          //   height: 300,
          //   color: grayPrimaryColor,
          //   child: FlutterLogo(),
          // ),
          ...List.generate(
            fields.length,
            (index) => CardField(
              fieldName: '${fields[index].title}',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => FieldScreen(
                      field: fields[index],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
