import 'package:flutter/material.dart';

Size sized(BuildContext context) => MediaQuery.of(context).size;

const String UiFont = 'Comfortaa';

const String defaultImagePath = "assets/images/default/photo_symbol.png";
const String defaultImagePathLandscape = "assets/images/default/image_symbol_landscape.png";
// const String defaultImage = "assets/images/clubs/club-1.jpg";
Opacity buildDefaultImage() => Opacity(
      opacity: 0.5,
      child: Image(
        image: AssetImage(defaultImagePath),
      ),
    );

// void getDelayed({@required int milliseconds}){
//   Future.delayed(Duration(milliseconds: milliseconds), () => setState(() {}));
// }



const Color whiteBackgroundColor = Colors.white60;
const Color blackPrimaryColor = Color(0xFF222831);
const Color redPrimaryColor = Color(0xFFf05454);
const Color whitePrimaryColor = Color(0xFFdddddd);

const Color grayPrimaryColor = Color(0xFFe7e6e1);
const Color creamPrimaryColor = Color(0xFFf7f6e7);
const Color orangePrimaryColor = Color(0xFFf2a154);
const Color navyPrimaryColor = Color(0xFF314e52);
