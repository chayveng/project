import 'package:flutter/material.dart';

class UserImage extends StatelessWidget {
  final String userName;

  const UserImage({
    Key key,
    @required this.userName,
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
        userImage(),
        buttonImage(),
      ],
    );
  }

  Column userImage() {
    return Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    color: Colors.yellow,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Icon(
                    Icons.person,
                    size: 100,
                    color: Colors.black.withOpacity(0.7),
                  ),
                ),
              ],
            ),
          ),
        ],
      );
  }

  Widget buttonImage() {
    return Positioned(
      bottom: 1,
      right: 1,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(50),
        child: Material(
          color: Colors.redAccent,
          child: InkWell(
            onTap: () {
              print('on select image');
            },
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Icon(
                Icons.add_a_photo,
                size: 18,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
