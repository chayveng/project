import 'dart:io';

import 'package:flutter/material.dart';
import 'package:project_app/ui/components/get_image_network.dart';

import '../../../../constants.dart';

class FieldImage extends StatelessWidget {
  final File image;
  final String photosPath;
  final GestureTapCallback onTap;

  const FieldImage({
    Key key,
    this.image,
    this.onTap,
    this.photosPath,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      width: sized(context).width,
      child: (image == null)
          ? GestureDetector(
              child: GetImageNetwork(photosPath: photosPath),
              // child: buildDefaultImage(),
              onTap: onTap,
            )
          : GestureDetector(
              child: Image.file(
                image,
                fit: BoxFit.cover,
              ),
              onTap: onTap,
            ),
    );
  }
}
