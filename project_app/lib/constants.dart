import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:location/location.dart';
import 'package:url_launcher/url_launcher.dart';

const String UiFont = 'Kanit';
// const String UiFont = 'Comfortaa';

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

const Color orangeColor = Color.fromRGBO(253, 108, 43, 1);
const Color whiteColor = Color.fromRGBO(255, 255, 255, 1);
const Color greyColor = Color.fromRGBO(240, 240, 250, 1);
const Color blackColor = Color.fromRGBO(33, 33, 33, 1);
// const Color colorsAccept = Color.fromRGBO(33, 33, 33, 1);

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

Future<File?> chooseImage(ImageSource? imageSource) async {
  ImagePicker imagePicker = ImagePicker();
  File? image;
  try {
    var _image = await imagePicker.getImage(
        source: imageSource!, maxHeight: 1000, maxWidth: 1000);
    if (_image != null) {
      image = File(_image.path);
    }
  } catch (e) {
    print('error chooseImage');
  }
  return image;
}

LatLng getLocation(String lct) {
  int index = lct.indexOf(',');
  double lat = double.parse(lct.substring(0, index));
  double lng = double.parse(lct.substring(index + 1, lct.length));
  var locationData = LatLng(lat, lng);
  return locationData;
}

Future<double?> findDistance(String lct) async {
  LocationData currentLocation = (await findLocationData())!;
  print(currentLocation);
  LatLng lctData = getLocation(lct);
  double _distance = calculateDistance(
    currentLocation.latitude!,
    currentLocation.longitude!,
    lctData.latitude,
    lctData.longitude,
  );
  return _distance;
}

Future<LocationData?> findLocationData() async {
  Location location = Location();
  try {
    return await location.getLocation();
  } catch (e) {
    return null;
  }
}

LatLng decodeLct(String lct) {
  int comma = lct.indexOf(',');
  double lat = double.parse(lct.substring(0, comma));
  double lng = double.parse(lct.substring(comma + 1, lct.length - 1));
  return LatLng(lat, lng);
}

String encodeLct(LatLng lct) {
  return '${lct.longitude},${lct.longitude}';
}

Future<void> mapLauncher(double lat, double lng) async {
  String googleUrl =
      'https://www.google.com/maps/search/?api=1&query=$lat,$lng';
  String encodeUrl = Uri.encodeFull(googleUrl);
  if (await canLaunch(encodeUrl)) {
    await launch(encodeUrl);
  } else {
    throw "Could not open the map.";
  }
}

Future getCurrentLocation() async {
  Location location = Location();
  try {
    LocationData lct = await location.getLocation();
    return lct;
  } catch (e) {
    print(e.toString());
    return null;
    // return LatLng(100, 100);
  }
}

double calculateDistance(double lat1, double lng1, double lat2, double lng2) {
  double distance = 0;
  var p = 0.017453292519943295;
  var c = cos;
  var a = 0.5 -
      c((lat2 - lat1) * p) / 2 +
      c(lat1 * p) * c(lat2 * p) * (1 - c((lng2 - lng1) * p)) / 2;
  distance = 12742 * asin(sqrt(a));

  return distance;
}
