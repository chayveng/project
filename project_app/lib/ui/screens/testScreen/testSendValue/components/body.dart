import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Body extends StatefulWidget {
  final File newImage;

  const Body({Key key, this.newImage}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  File _image;
  String mainText;

  Future<void> chooseImage(ImageSource imageSource) async {
    _image = null;
    try {
      var image = await ImagePicker.pickImage(
        source: imageSource,
        maxWidth: 800.0,
        maxHeight: 800.0,
        imageQuality: 75,
      );

      print('chooseImage');
      setState(() {
        _image = image;
      });
    } catch (e) {
      print("error");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SectionImage(fileImage: _image),
          // SectionImage(fileImage: widget.newImage),
          ElevatedButton(
            child: Text('choose image'),
            onPressed: () => chooseImage(ImageSource.gallery),
          ),
          Text(mainText ?? ''),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50),
            child: TextFormField(decoration: InputDecoration(hintText: 'test')),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50),
            child: TextFormField(decoration: InputDecoration(hintText: 'test')),
          ),
          ElevatedButton(
            child: Text('Button 1'),
            onPressed: () async {},
          ),
        ],
      ),
    );
  }
}

class SectionImage extends StatefulWidget {
  final File fileImage;

  const SectionImage({Key key, this.fileImage}) : super(key: key);

  @override
  _SectionImageState createState() => _SectionImageState();
}

class _SectionImageState extends State<SectionImage> {
  File _image;

  Future<void> chooseImage(ImageSource imageSource) async {
    _image = null;
    try {
      var image = await ImagePicker.pickImage(
        source: imageSource,
        maxWidth: 800.0,
        maxHeight: 800.0,
        imageQuality: 75,
      );
      setState(() {
        _image = image;
      });
    } catch (e) {
      print("error");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('Section Image'),
        Container(
          width: 200,
          height: 200,
          color: Colors.yellowAccent,
          child: widget.fileImage != null
              ? Image.file(
                  widget.fileImage,
                  fit: BoxFit.cover,
                )
              : SizedBox(),
        ),
        ElevatedButton(
          child: Text('_choose'),
          onPressed: () => chooseImage(ImageSource.gallery),
        ),
      ],
    );
  }
}
