import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../../constants.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  List<File> lst = [];
  int index = 0;

  Future<void> _chooseImages(ImageSource imageSource) async {
    ImagePicker imagePicker = ImagePicker();
    try {
      var image = await imagePicker.getImage(source: imageSource);
      if (image != null) {
        setState(() => lst.add(File(image.path)));
      }
    } catch (e) {
      print("error");
    }
  }

  Widget buildImage(index) {
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
                  lst[index],
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
              lst[index] = null;
              lst.remove(null);
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
      onTap: () async => await _chooseImages(ImageSource.gallery),
    );
  }

  Widget buildImages(index) {
    if (lst.length == index) {
      return addImage(index);
    } else if (lst.length > index) {
      return buildImage(index);
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
      color: Colors.grey.withOpacity(0.3),
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 30),
            buildFormGrid(),
            Container(
              height: 300,
              width: sized(context).width,
              color: Colors.amber,
              child: Stack(
                children: [
                  buildImageBox(),
                  buildArrow(),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ...List.generate(lst.length,
                            (index) => buildRadioCurrentState(index)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Padding buildRadioCurrentState(int currentState) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: AnimatedContainer(
        height: 10,
        width: index == currentState ? 50 : 10,
        duration: Duration(milliseconds: 200),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(50),
        ),
      ),
    );
  }

  Widget buildImageBox() {
    return lst.isEmpty
        ? Container(
            child: Text('Empty'),
          )
        : Container(
            width: double.maxFinite,
            height: double.maxFinite,
            child: Image.file(
              lst[index],
              fit: BoxFit.cover,
            ),
          );
  }

  Center buildArrow() {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            child: Icon(
              Icons.arrow_back_ios_rounded,
              color: Colors.white,
              size: 40,
            ),
            onTap: () {
              if (index != 0) {
                setState(() {
                  index = index - 1;
                  print('index: $index');
                });
              }
            },
          ),
          GestureDetector(
            child: Icon(
              Icons.arrow_forward_ios_rounded,
              color: Colors.white,
              size: 40,
            ),
            onTap: () {
              if (index != lst.length - 1) {
                setState(() {
                  index = index + 1;
                  print('index: $index');
                });
              }
            },
          ),
        ],
      ),
    );
  }
}
