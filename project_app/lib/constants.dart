import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

const String UiFont = 'Comfortaa';

const String defaultImagePath = "assets/images/default/photo_symbol.png";
const String defaultImagePathLandscape =
    "assets/images/default/image_symbol_landscape.png";

const Color whiteBackgroundColor = Colors.white60;
const Color blackPrimaryColor = Color(0xFF222831);
const Color redPrimaryColor = Color(0xFFf05454);
const Color greyPrimaryColor = Color(0xFFe7e6e1);
const Color creamPrimaryColor = Color(0xFFf7f6e7);
const Color orangePrimaryColor = Color(0xFFf2a154);
const Color navyPrimaryColor = Color(0xFF314e52);

Size sized(BuildContext context) => MediaQuery.of(context).size;

Opacity buildDefaultImage() {
  return Opacity(
    opacity: 0.5,
    child: Image(
      image: AssetImage(defaultImagePath),
    ),
  );
}

Widget testButton({@required VoidCallback? onPressed, String? text}) {
  return ElevatedButton(
    onPressed: onPressed,
    child: Text('${text != null ? text : 'Test Button'}'),
  );
}

Widget testBox({double? sized, Color? color}) => Container(
      height: sized ?? 200,
      width: sized ?? 200,
      color: color ?? Colors.redAccent,
    );

Future<File> chooseImage(ImageSource? imageSource) async {
  ImagePicker imagePicker = ImagePicker();
  File? image;
  try {
    var _image = await imagePicker.getImage(source: imageSource!);
    if (_image != null) {
      image = File(_image.path);
    }
  } catch (e) {
    print('error chooseImage');
  }
  return image!;
}
