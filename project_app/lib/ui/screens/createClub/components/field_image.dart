import 'dart:io';

import 'package:flutter/material.dart';

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
              child: Icon(
                Icons.add_a_photo,
                size: sized(context).width * 0.5,
                color: Colors.black.withOpacity(0.5),
              ),
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
