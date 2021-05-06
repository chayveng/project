import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:project_app/core/models/ClubLocation.dart';
import 'package:project_app/ui/components/custom_dialog_loading.dart';

import '../../../../../constants.dart';

class Body extends StatefulWidget {
  const Body({Key key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  List<Marker> handleMarker = [];
  Location location = new Location();
  LocationData currentLocation;
  ClubLocation clubLct = new ClubLocation(
    latitude: 16.431387560289423,
    longitude: 102.81499053196279,
  );

  @override
  void initState() {
    getCurrentLocation();
    super.initState();
  }

  void _handleTap(LatLng tappedPoint) {
    print(tappedPoint);
    setState(() {
      handleMarker = [];
      handleMarker.add(
        Marker(
            markerId: MarkerId(tappedPoint.toString()),
            position: tappedPoint,
            draggable: true,
            onDragEnd: (dragEndPosition) {
              print(dragEndPosition);
            }),
      );
    });
  }

  Widget buildMap() {
    LatLng latLng = LatLng(clubLct.latitude, clubLct.longitude);
    CameraPosition cameraPosition = CameraPosition(target: latLng, zoom: 16.0);
    return GoogleMap(
      zoomGesturesEnabled: false,
      initialCameraPosition: cameraPosition,
      // mapType: MapType.normal,
      // onMapCreated: (controller) {},
      onTap: _handleTap,
      markers: Set.from(handleMarker),
      // markers: myMarker(),
    );
  }

  Set<Marker> myMarker() {
    return <Marker>[
      Marker(
          draggable: true,
          markerId: MarkerId('myClub'),
          position: LatLng(clubLct.latitude, clubLct.longitude),
          infoWindow: InfoWindow(
            title: 'Your mark',
            snippet: 'lat = ${clubLct.latitude} , lng = ${clubLct.longitude}',
          ),
          onTap: () {
            print(
                'Marker lat = ${clubLct.latitude} , lng = ${clubLct.longitude}');
          }),
    ].toSet();
  }

  Future<void> getCurrentLocation() async {
    clubLct = ClubLocation(
      latitude: 16.431387560289423,
      longitude: 102.81499053196279,
    );
    // clubLct = ClubLocation();
    currentLocation = await location.getLocation();
    // clubLct.latitude = currentLocation.latitude;
    // clubLct.longitude = currentLocation.longitude;
    setState(() {});
  }

  Widget buildSectionMap(BuildContext context) {
    return Container(
      width: sized(context).width,
      height: sized(context).height * 0.5,
      color: Colors.white,
      child: clubLct.latitude != null
          ? Container(child: buildMap())
          : CustomDialogLoading(),
    );
  }

  Widget buildGetLocation() {
    return ElevatedButton(
      child: Text('get location'),
      onPressed: () async => await getCurrentLocation(),
    );
  }

  ElevatedButton buildSetState() {
    return ElevatedButton(
      onPressed: () => setState(() => print('SetState')),
      child: Text('setState'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          buildSetState(),
          buildSectionMap(context),
          buildGetLocation(),
          ElevatedButton(
            child: Text('My location'),
            onPressed: () {
              LatLng latLng = LatLng(clubLct.latitude, clubLct.longitude);
              print(latLng);
            },
          ),
        ],
      ),
    );
  }
}
