import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:project_app/ui/components/custom_dialog_loading.dart';

import '../../../constants.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  double lat, lng;
  LocationData currentLocation;

  @override
  void initState() {
    super.initState();
    findLatLng();
  }

  Future<Null> findLatLng() async {
    print('findLatLng');
    LocationData locationData = await findLocationData();
    setState(() {
      lat = locationData.latitude;
      lng = locationData.longitude;
    });
    print('lat = $lat , lng = $lng');
  }

  Future<LocationData> findLocationData() async {
    Location location = Location();
    try {
      return location.getLocation();
    } catch (e) {
      return null;
    }
  }


  Container buildMap() {
    LatLng latLng = LatLng(lat, lng);
    CameraPosition cameraPosition = CameraPosition(
      target: latLng,
      zoom: 16.0,
    );
    return Container(
      width: sized(context).width,
      height: sized(context).height,
      // color: Colors.red,
      child: GoogleMap(
        initialCameraPosition: cameraPosition,
        mapType: MapType.normal,
        onMapCreated: (controller) {},
        markers: myMarker(),
      ),
    );
  }

  Set<Marker> myMarker() {
    return <Marker>[
      Marker(
          draggable: true,
          markerId: MarkerId('myClub'),
          position: LatLng(lat, lng),
          infoWindow: InfoWindow(
            title: 'Your mark',
            snippet: 'lat = $lat , lng = $lng',
          ),
          onTap: () {
            print('Marker lat = $lat , lng = $lng');
          }),
    ].toSet();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: lat == null ? CustomDialogLoading() : buildMap(),
      ),
    );
  }
}
