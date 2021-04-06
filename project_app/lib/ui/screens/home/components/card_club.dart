import 'package:flutter/material.dart';
import 'package:project_app/core/models/Club.dart';
import 'package:project_app/ui/components/get_image_network.dart';

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
                  height: 250,width: sized(context).width,
                  child: GetImageNetwork(
                    landscape: true,
                    photosPath: club.photosPath,
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.only(
                          top: 8.0, left: 8.0, right: 8.0),
                      child: Text(
                        (club.title) ?? '',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Container(
                      width: sized(context).width,
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        club.detail ?? '',
                        style: TextStyle(
                          fontSize: 14,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
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
