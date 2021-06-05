import 'dart:io';
import 'dart:typed_data';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../constants.dart';

class SectionImages extends StatefulWidget {
  final List<Uint8List> images;

  const SectionImages({Key key, this.images}) : super(key: key);

  @override
  _SectionImagesState createState() => _SectionImagesState();
}

class _SectionImagesState extends State<SectionImages> {
  int _current = 0;

  Future<void> _chooseImage() async {
    File image = await chooseImage(ImageSource.gallery);
    if (image != null)
      setState(() => widget.images.add(image.readAsBytesSync()));
  }

  void _removeImage() {
    setState(() => widget.images.removeLast());
  }

  Widget customBtn() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          icon: Icon(Icons.remove),
          onPressed: () => _removeImage(),
        ),
        SizedBox(width: 10),
        IconButton(
          icon: Icon(Icons.add),
          onPressed: () async => await _chooseImage(),
        ),
      ],
    );
  }

  Widget indicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ...List.generate(
          widget.images.length,
          (index) {
            return Container(
            width: 8.0,
            height: 8.0,
            margin: EdgeInsets.symmetric(vertical: 10, horizontal: 2),
            decoration: BoxDecoration(
              color: _current == index ? Colors.black87 : Colors.black12,
              shape: BoxShape.circle,
            ),
          );
          },
        ),
      ],
    );
  }

  Widget formImages() {
    return CarouselSlider(
      options: CarouselOptions(
        height: sized(context).height * 0.33,
        viewportFraction: 1.0,
        enableInfiniteScroll: false,
        onPageChanged: (index, reason) {
          setState(() => _current = index);
        },
      ),
      items: widget.images
          .map(
            (item) => Container(
              width: double.infinity,
              height: double.infinity,
              child: Image.memory(item, fit: BoxFit.cover),
            ),
          )
          .toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      width: sized(context).width,
      child: Stack(
        children: [
          formImages(),
          Align(alignment: Alignment.bottomCenter,child: indicator()),
        ],
      ),
    );
  }
}
