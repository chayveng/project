
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project_app/ui/screens/testScreen/newCreateClubScreen/components/sectionImags/add_image.dart';
import 'package:project_app/ui/screens/testScreen/newCreateClubScreen/components/sectionImags/form_image.dart';

import '../../../../../../constants.dart';

class SectionImagestest extends StatefulWidget {
  final List<Uint8List> images;

  const SectionImagestest({
    Key key,
    @required this.images,
  }) : super(key: key);

  @override
  _SectionImagestestState createState() => _SectionImagestestState();
}

class _SectionImagestestState extends State<SectionImagestest> {
  void onRemoveImage(index) {
    widget.images[index] = null;
    widget.images.remove(null);
    setState(() {});
  }

  Future<void> onChooseImage() async {
    var image = await chooseImage(ImageSource.gallery);
    if (image != null) {
      setState(() => widget.images.add(image.readAsBytesSync()));
    }
  }

  Widget buildImages(index) {
    if (widget.images.length == index) {
      return AddImage(onChooseImage: () async => await onChooseImage());
    } else if (widget.images.length > index) {
      return FormImage(
        image: widget.images[index],
        onRemove: () => onRemoveImage(index),
      );
    } else {
      return SizedBox();
    }
  }

  Widget buildFormGrid() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
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
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: creamPrimaryColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Icon(Icons.image),
                  SizedBox(width: 10),
                  Text('Images', style: TextStyle(fontWeight: FontWeight.bold)),
                ],
              ),
            ),
            buildFormGrid(),
          ],
        ),
      ),
    );
  }
}
