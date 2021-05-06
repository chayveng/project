import 'dart:async';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:project_app/ui/components/custom_dialog_loading.dart';

Size sized(BuildContext context) => MediaQuery.of(context).size;

const String UiFont = 'Comfortaa';

const String defaultImagePath = "assets/images/default/photo_symbol.png";
const String defaultImagePathLandscape =
    "assets/images/default/image_symbol_landscape.png";

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

const Color whiteBackgroundColor = Colors.white60;
const Color blackPrimaryColor = Color(0xFF222831);
const Color redPrimaryColor = Color(0xFFf05454);
const Color whitePrimaryColor = Color(0xFFdddddd);

const Color grayPrimaryColor = Color(0xFFe7e6e1);
const Color creamPrimaryColor = Color(0xFFf7f6e7);
const Color orangePrimaryColor = Color(0xFFf2a154);
const Color navyPrimaryColor = Color(0xFF314e52);
