import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project_app/ui/screens/club/components/isCreate/components/sectionImages/title_bar.dart';

import '../../../../../../../constants.dart';

class SectionImage extends StatefulWidget {
  final List<Uint8List> images;
  final VoidCallback upload;
  final VoidCallback download;

  const SectionImage({Key key, this.images, this.upload, this.download})
      : super(key: key);

  @override
  _SectionImageState createState() => _SectionImageState();
}

class _SectionImageState extends State<SectionImage> {
  Future<void> _remove(int index) async {
    setState(() => widget.images.removeAt(index));
  }

  Future<void> _addImage() async {
    var res = await chooseImage(ImageSource.gallery);
    if (res != null) setState(() => widget.images.add(res.readAsBytesSync()));
  }

  Widget buildImage(int index) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.all(5),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Container(
              width: double.infinity,
              height: double.infinity,
              child: Image.memory(
                widget.images[index],
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: () async => await _remove(index),
          child: Align(
            alignment: Alignment.topRight,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(50),
              ),
              child: Icon(Icons.remove),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildFormImage(int index) {
    if (index < widget.images.length) {
      return buildImage(index);
    } else if (index == widget.images.length) {
      return Center(
        child: GestureDetector(
          onTap: () async => await _addImage(),
          child: Icon(Icons.add_rounded,size: 28,),
        ),
      );
    } else {
      return SizedBox();
    }
  }

  Widget sectionImages() {
    return SafeArea(
      child: Container(
        padding: EdgeInsets.all(2),
        child: GridView.count(
          primary: false,
          shrinkWrap: true,
          crossAxisCount: 3,
          children: [
            ...List.generate(
              6,
              (index) => Container(
                width: double.infinity,
                height: double.infinity,
                // color: Colors.redAccent,
                child: buildFormImage(index),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: creamPrimaryColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            TitleBar(),
            sectionImages(),
          ],
        ),
      ),
    );
  }
}
