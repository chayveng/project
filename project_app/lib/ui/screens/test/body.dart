import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:project_app/core/models/Field.dart';

import '../../../constants.dart';

class Body extends StatefulWidget {
  const Body({
    Key? key,
  }) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  List<Field> fields = [
    Field(title: 'ศาลหลักเมือง', location: '16.4314451,102.8268332'),
    Field(title: 'พงษ์', location: '16.4359978,102.8226058'),
    Field(title: 'ศรี', location: '16.460182,102.8175972'),
  ];
  List<Field> newFields = [];
  Field field = Field();
  double? lat1, lng1, distance;
  double? lat2 = 16.6507692;
  double? lng2 = 102.8951267;

  LatLng getLocation(String lct) {
    int index = lct.indexOf(',');
    double lat = double.parse(lct.substring(0, index));
    double lng = double.parse(lct.substring(index + 1, lct.length));
    var locationData = LatLng(lat, lng);
    return locationData;
  }

  @override
  void initState() {
    super.initState();
    findByLocation3km();
    // findDistance();
    // findLat1Lng1();
  }

  Future<void> findByLocation3km() async {
    for (int i = 0; i < fields.length; i++) {
      double? _distance = await findDistance(fields[i].location!);
      print('${fields[i].title}: ${_distance}');
      if (_distance! > 3.0) {
        setState(() {
          newFields.add(fields[i]);
        });
      }
    }
    print('น้อยกว่า 3 กม');
    for (int i = 0; i < newFields.length; i++) {
      print('${newFields[i].title}');
    }
  }

  // Future<double?> findDistance(String lct) async {
  //   LocationData locationData = (await findLocationData())!;
  //   // print(locationData);
  //   // setState(() {
  //   lat1 = locationData.latitude;
  //   lng1 = locationData.longitude;
  //   LatLng lctData = getLocation(lct);
  //   double _distance = calculateDistance(
  //     lat1!,
  //     lng1!,
  //     lctData.latitude,
  //     lctData.longitude,
  //   );
  //   return _distance;
  // }

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

  Future<LocationData?> findLocationData() async {
    Location location = Location();
    try {
      return await location.getLocation();
    } catch (e) {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: sized(context).width,
      child: ElevatedButton(
        onPressed: () async {
        double distance = (await findDistance(fields[1].location!))!;
        print(distance);
        },
        child: Text('ff'),
      ),
    );
  }
}
