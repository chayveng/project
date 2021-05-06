import 'package:flutter/material.dart';
import 'package:location/location.dart';

class Body extends StatefulWidget {
  const Body({Key key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  var location = Location();
  var currentLocation;

  Future<void> getCurrentLocation() async {
    currentLocation = await location.getLocation();
    setState(() {});
  }

  // void checkServiceEnabled() async {
  //   var _serviceEnabled = await location.serviceEnabled();
  //   if (!_serviceEnabled) {
  //     _serviceEnabled = await location.requestService();
  //     if (!_serviceEnabled) {
  //       return null;
  //     }
  //   }
  // }

  // void checkPermissionGranted() async {
  //   var _permissionGranted = await location.hasPermission();
  //   if (_permissionGranted == PermissionStatus.denied) {
  //     _permissionGranted = await location.requestPermission();
  //     if (_permissionGranted != PermissionStatus.granted) {
  //       return null;
  //     }
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(currentLocation.toString() ?? ''),
            ElevatedButton(
              child: Text('get location'),
              onPressed: () async {
                await getCurrentLocation();
                print(currentLocation.toString());
              },
            ),
          ],
        ),
      ),
    );
  }
}
