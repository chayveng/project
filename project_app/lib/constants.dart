import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project_app/ui/components/custom_dialog_loading.dart';

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

Future buildDialogLoading(BuildContext context, int millisecond) {
  return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        Future.delayed(Duration(milliseconds: millisecond), () {
          Navigator.of(context).pop();
        });
        return CustomDialogLoading();
      });
}

Widget testBox({double sized, Color color}) => Container(
      height: sized ?? 200,
      width: sized ?? 200,
      color: color ?? Colors.redAccent,
    );

Widget testButton({String text, Function onPressed}) => ElevatedButton(
      onPressed: onPressed ?? () => print(text ?? 'Test Button ><!'),
      child: Text(text ?? 'Test Button'),
    );

Future<File> chooseImage(ImageSource imageSource) async {
  ImagePicker imagePicker = ImagePicker();
  File image;
  try {
    var _image =  await imagePicker.getImage(source: imageSource);
    if (_image != null) {
      image = File(_image.path);
    }else{
      image = null;
    }
  }catch (e){
    print('error chooseImage');
  }
  return image;
}

// Future<void> chooseImage(ImageSource imageSource) async {
//   ImagePicker imagePicker = ImagePicker();
//   try {
//     var image = await imagePicker.getImage(source: imageSource);
//     if (image != null) {
//       setState(() => images.add(File(image.path)));
//     }
//   } catch (e) {
//     print("error");
//   }
// }
