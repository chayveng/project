import 'package:flutter/material.dart';

class ViewImages extends StatefulWidget {
  @override
  _ViewImagesState createState() => _ViewImagesState();
}

class _ViewImagesState extends State<ViewImages> {
  final List<String> photos = [
    'assets/images/clubs/club-1.jpg',
    'assets/images/clubs/club-2.jpg',
    'assets/images/clubs/club-3.jpg',
    'assets/images/clubs/club-4.jpg',
    'assets/images/clubs/club-5.jpg',
    'assets/images/clubs/club-6.jpg',
    'assets/images/clubs/club-7.jpg',
    'assets/images/clubs/club-8.jpg',
    'assets/images/clubs/club-9.jpg',
    'assets/images/clubs/club-10.jpg',
  ];
  int count = 0;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: buildPhoto(),
    );
  }

  Column buildPhoto() {
    // print(photos.length);
    print(count);
    photos.length;
    return Column(
      children: [
        Image(
          image: AssetImage('${photos[count]}'),
        ),
        RaisedButton(
          child: Text('Next'),
          onPressed: () {
            setState(() {
              (count >= photos.length-1) ? count = 0 : count++;
            });
          },
        ),
      ],
    );
  }
}
