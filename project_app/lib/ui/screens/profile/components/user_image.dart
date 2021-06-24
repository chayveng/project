import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:project_app/constants.dart';

class UserImage extends StatelessWidget {
  final String? userName;
  final Uint8List? image;
  final GestureTapCallback? onTap;
  final bool? status;

  const UserImage({
    Key? key,
    @required this.userName,
   @required this.image,
    @required this.status,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        formUserImage(),
        userText(),
      ],
    );
  }

  Widget userText() {
    return Text(
      userName ?? '',
      style: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget formUserImage() {
    return Stack(
      children: [
        _userImage(),
        buttonImage(),
      ],
    );
  }

  Column _userImage() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    color: whiteColor,
                  ),
                  child: buildUserImage(),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget buildUserImage() {
    if (image != null) {
      return Image.memory(
        image!,
        fit: BoxFit.cover,
      );
    } else {
      return Icon(
        Icons.person,
        size: 100,
        color: navyPrimaryColor.withOpacity(0.7),
      );
    }
  }

  Widget buttonImage() {
    return status! ? Positioned(
      bottom: 1,
      right: 1,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(50),
        child: Material(
          color: orangePrimaryColor,
          child: InkWell(
            onTap: onTap,
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Icon(
                Icons.add_a_photo,
                color: navyPrimaryColor,
                size: 18,
              ),
            ),
          ),
        ),
      ),
    ): SizedBox();
  }
}
