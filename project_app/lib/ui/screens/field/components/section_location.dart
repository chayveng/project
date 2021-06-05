import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class SectionLocation extends StatefulWidget {
  const SectionLocation({Key key}) : super(key: key);

  @override
  _SectionLocationState createState() => _SectionLocationState();
}

class _SectionLocationState extends State<SectionLocation> {
  double lat = 16.431387560289423, lng = 102.81499053196279;
  LatLng currentLocation;

  Set<Marker> markers;

  @override
  void initState() {
    setLocation();
    super.initState();
  }

  void setLocation() {
    currentLocation = LatLng(lat, lng);
    markers = [
      Marker(
        markerId: MarkerId('location'),
        position: LatLng(lat, lng),
      ),
    ].toSet();
  }

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      zoomGesturesEnabled: true,
      initialCameraPosition:
          CameraPosition(target: currentLocation, zoom: 16.0),
      mapType: MapType.normal,
      myLocationEnabled: true,
      myLocationButtonEnabled: false,
      markers: markers,

    );
  }
}
