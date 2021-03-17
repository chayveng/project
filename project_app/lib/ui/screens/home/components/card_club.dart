import 'package:flutter/material.dart';
import 'package:project_app/core/models/Club.dart';

import '../../../../constants.dart';

class CardClub extends StatelessWidget {
  final AssetImage image;
  final GestureTapCallback onTap;
  final Club club;

  const CardClub({
    Key key,
    this.image,
    @required this.onTap,
    @required this.club,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size sized = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.only(top: 8,left: 8,right: 8),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Material(
          color: creamPrimaryColor,
          child: InkWell(
            onTap: onTap,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 150,
                  width: sized.width,
                  child: Image(image: AssetImage(club.photoPath),),
                  // child: FlutterLogo(),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    club.title,
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    club.detail,
                    style: TextStyle(
                      fontSize: 14,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
