import 'dart:typed_data';

import 'package:flutter/material.dart';

class NewUserImage extends StatelessWidget {
  final Uint8List? image;

  // final GestureTapCallback? onTap;
  // final bool? status;

  const NewUserImage({
    Key? key,
    this.image,
    // this.onTap,
    // this.status,
  }) : super(key: key);

  // Widget formUserImage() {
  //   return Stack(
  //     children: [
  //       // _userImage(),
  //       // buttonImage(),
  //     ],
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 200,
          height: 200,
          child: image != null ? Image.memory(image!) : SizedBox(),
        ),
        // formUserImage(),
        // userText(),
      ],
    );
  }
}
