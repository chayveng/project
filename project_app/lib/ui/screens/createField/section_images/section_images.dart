import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project_app/ui/components/title_form_field.dart';

import '../../../../constants.dart';

class SectionImages extends StatefulWidget {
  final List<Uint8List>? images;

  const SectionImages({
    Key? key,
    @required this.images,
  }) : super(key: key);

  @override
  _SectionImagesState createState() => _SectionImagesState();
}

class _SectionImagesState extends State<SectionImages> {
  double inSidePadding = 8;

  Future<void> _remove(int index) async {
    setState(() => widget.images!.removeAt(index));
  }

  Future<void> _addImage() async {
    var res = await chooseImage(ImageSource.gallery);
    if (res != null) setState(() => widget.images!.add(res.readAsBytesSync()));
  }

  Widget buildAddImage() {
    return GestureDetector(
      onTap: () async => await _addImage(),
      child: Container(
        width: double.infinity,
        height: double.infinity,
        color: greyColor,
        child: Icon(
          Icons.add_rounded,
          size: 28,
        ),
      ),
    );
  }

  Widget buildImage(int index) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.all(0.01),
          child: Container(
            width: double.infinity,
            height: double.infinity,
            child: Image.memory(
              widget.images![index],
              fit: BoxFit.cover,
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
    if (index < widget.images!.length) {
      return buildImage(index);
    } else if (index == widget.images!.length) {
      return Center(
        child: buildAddImage(),
      );
    } else {
      return SizedBox();
    }
  }

  Widget sectionImages() {
    return GridView.count(
      primary: false,
      shrinkWrap: true,
      crossAxisCount: 3,
      padding: EdgeInsets.all(inSidePadding),
      mainAxisSpacing: inSidePadding,
      crossAxisSpacing: inSidePadding,
      children: [
        ...List.generate(
          6,
          (index) => ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: buildFormImage(index),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: whiteColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          TitleFormField(iconData: Icons.image, title: 'รูปสนาม'),
          sectionImages(),
        ],
      ),
    );
  }
}
