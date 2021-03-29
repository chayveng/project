import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:project_app/core/services/ClubService.dart';

import '../../constants.dart';

class GetImageNetwork extends StatelessWidget {
  final String photosPath;
  final bool landscape;

  const GetImageNetwork({
    Key key,
    @required this.photosPath,
    this.landscape = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (photosPath != null) {
      return Image.network(
        ClubService.mainImage(fileName: photosPath),
          // width: double.infinity,
          // height: double.infinity,
          fit: BoxFit.cover,
      );
      // return FadeInImage.assetNetwork(
      //   placeholder: defaultImagePath,
      //   image: ClubService.mainImage(fileName: photosPath),
      //   width: double.infinity,
      //   height: double.infinity,
      //   fit: BoxFit.fill,
      // );
    } else {
      return Container(
        padding: EdgeInsets.all(12.0),
        child: Opacity(
          opacity: 0.5,
          child: Image.asset(
            landscape == true ? defaultImagePathLandscape : defaultImagePath,
          ),
        ),
      );
      return Container();
    }
  }
}
