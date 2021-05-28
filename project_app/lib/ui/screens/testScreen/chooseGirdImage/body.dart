import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../constants.dart';

class Body extends StatefulWidget {
  const Body({Key key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  List<File> images = [];
  int index = 0;

  Future<void> _chooseImages() async {
    var image = await chooseImage(ImageSource.gallery);
    if (image != null) {
      setState(() => images.add(image));
    }
  }

  Widget formImage(index) {
    double spacing = sized(context).width * 0.015;
    return Stack(
      children: [
        Padding(
          padding: EdgeInsets.all(spacing),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Material(
              child: Container(
                width: double.maxFinite,
                height: double.maxFinite,
                color: Colors.yellow,
                child: Image.file(
                  images[index],
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ),
        Align(
          alignment: Alignment.topRight,
          child: GestureDetector(
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.red, borderRadius: BorderRadius.circular(50)),
              child: Icon(Icons.remove, size: sized(context).width * 0.05),
            ),
            onTap: () {
              images[index] = null;
              images.remove(null);
              this.index = 0;
              setState(() {});
            },
          ),
        ),
      ],
    );
  }

  Widget addImage(index) {
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
      onTap: () async => await _chooseImages(),
    );
  }

  Widget buildImages(index) {
    if (images.length == index) {
      return addImage(index);
    } else if (images.length > index) {
      return formImage(index);
    } else {
      return SizedBox();
    }
  }

  Widget buildFormGrid() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Container(
        child: GridView.count(
          crossAxisCount: 3,
          shrinkWrap: true,
          primary: false,
          children: [...List.generate(6, (index) => buildImages(index))],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          SizedBox(height: 30),
          buildFormGrid(),
        ],
      ),
    );
  }
}
