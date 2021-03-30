import 'package:flutter/material.dart';
import 'package:project_app/ui/components/custom_dialog_loading.dart';

const String UiFont = 'Comfortaa';

Size sized(BuildContext context) => MediaQuery.of(context).size;


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

const Color whiteBackgroundColor = Colors.white60;
const Color blackPrimaryColor = Color(0xFF222831);
const Color redPrimaryColor = Color(0xFFf05454);
const Color whitePrimaryColor = Color(0xFFdddddd);

const Color grayPrimaryColor = Color(0xFFe7e6e1);
const Color creamPrimaryColor = Color(0xFFf7f6e7);
const Color orangePrimaryColor = Color(0xFFf2a154);
const Color greenPrimaryColor = Color(0xFF314e52);
