import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../constants.dart';

class SectionImages extends StatefulWidget {
  final List<Uint8List>? images;

  const SectionImages({Key? key, this.images}) : super(key: key);

  @override
  _SectionImagesState createState() => _SectionImagesState();
}

class _SectionImagesState extends State<SectionImages> {
  int? _current = 0;

  Future<void> _chooseImage() async {
    File image = await chooseImage(ImageSource.gallery);
    if (image != null)
      setState(() => widget.images!.add(image.readAsBytesSync()));
  }

  void _removeImage() {
    setState(() => widget.images!.removeLast());
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
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ...List.generate(
              widget.images!.length,
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
        ),
      ],
    );
  }

  Widget formImages() {
    return widget.images!.length != 0
        ? Container(
            height: 250,
            width: sized(context).width,
            child: PageView.builder(
              itemCount: widget.images!.length, // Can be null
              onPageChanged: (index) => setState(() => _current = index),
              itemBuilder: (context, index) => Image.memory(
                widget.images![index],
                fit: BoxFit.cover,
              ),
            ),
          )
        : Container(
            height: 250,
            width: sized(context).width,
            child: Opacity(
              opacity: 0.3,
              child: Image.asset(
                'assets/images/default/image_symbol_landscape.png',
              ),
            ),
          );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: sized(context).width,
          child: Column(
            children: [
              formImages(),
              indicator(),
            ],
          ),
        ),
        // widget.isEdit ? customBtn() : SizedBox(),
      ],
    );
  }
}
