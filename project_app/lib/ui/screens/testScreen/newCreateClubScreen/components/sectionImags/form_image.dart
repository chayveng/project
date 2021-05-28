import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';

import '../../../../../../constants.dart';

class FormImage extends StatelessWidget {
  final Uint8List image;
  final GestureTapCallback onRemove;

  const FormImage({Key key, this.image, this.onRemove}) : super(key: key);

  Align removeIcon(BuildContext context) {
    return Align(
      alignment: Alignment.topRight,
      child: GestureDetector(
        child: Container(
          decoration: BoxDecoration(
              color: Colors.red, borderRadius: BorderRadius.circular(50)),
          child: Icon(Icons.remove, size: sized(context).width * 0.05),
        ),
        onTap: onRemove,
      ),
    );
  }

  Padding imageBox(BuildContext context) {
    double spacing = sized(context).width * 0.015;
    return Padding(
      padding: EdgeInsets.all(spacing),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Material(
          child: Container(
            width: double.maxFinite,
            height: double.maxFinite,
            color: greyPrimaryColor,
            child: Image.memory(image, fit: BoxFit.cover),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        imageBox(context),
        removeIcon(context),
      ],
    );
  }
}
