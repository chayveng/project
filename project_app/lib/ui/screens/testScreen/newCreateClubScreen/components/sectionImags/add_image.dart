import 'package:flutter/material.dart';

import '../../../../../../constants.dart';

class AddImage extends StatelessWidget {
  final GestureTapCallback onChooseImage;
  const AddImage({Key key,@required this.onChooseImage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double spacing = sized(context).width * 0.015;
      return GestureDetector(
        child: Padding(
          padding: EdgeInsets.all(spacing),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Material(
              child: Container(
                color: Colors.grey.withOpacity(0.5),
                child: Center(
                  child: Icon(Icons.add),
                ),
              ),
            ),
          ),
        ),
        onTap: onChooseImage,
      );

  }
}
