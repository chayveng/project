import 'package:flutter/material.dart';
import 'package:project_app/core/models/Club.dart';
import 'package:project_app/core/services/ClubService.dart';

import '../../../../config/Config.dart';
import '../../../../constants.dart';

class CardClub extends StatelessWidget {
  final AssetImage image;
  // final Function onTap;
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
      padding: const EdgeInsets.only(top: 8, left: 8, right: 8),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Material(
          color: creamPrimaryColor,
          child: InkWell(
            onTap: onTap,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 250,
                  width: sized.width,
                  child: FadeInImage.assetNetwork(
                    placeholder: defaultImage,
                    image: ClubService.mainImage(fileName: club.photosPath),
                    fit: BoxFit.cover,
                  ),
                  // child: FlutterLogo(),
                ),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.only(top:8.0, left: 8.0, right: 8.0),
                            child: Text(
                              (club.title) ?? 'null',
                              style: TextStyle(
                                fontSize: 16,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Container(
                            width: sized.width,
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              club.detail ?? 'null',
                              style: TextStyle(
                                fontSize: 14,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: RaisedButton(
                        color: orangePrimaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        // elevation: 0,
                        child: Text("Select"),
                        onPressed: () {},
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}