import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:project_app/core/models/FieldLocation.dart';
import 'package:project_app/ui/components/custom_dialog_loading.dart';

import '../../../../../constants.dart';

class SectionLocation extends StatefulWidget {
  final FieldLocation? fieldLocation;

  const SectionLocation({Key? key,
    this.fieldLocation}) : super(key: key);

  @override
  _SectionLocationState createState() => _SectionLocationState();
}

class _SectionLocationState extends State<SectionLocation> {
  List<Marker> handleMarker = [];
  Location location = Location();
  // FieldLocation fieldLocation = FieldLocation();
  CameraPosition? cameraPosition;
  LatLng? currentLocation;

  @override
  void initState() {
    setLocation();
    super.initState();
  }

  void setLocation() async {
    // LatLng myLocation = LatLng(16.431387560289423, 102.81499053196279);
    LocationData lctLocation = await location.getLocation();
    currentLocation = LatLng(lctLocation.latitude!, lctLocation.longitude!);
    widget.fieldLocation!.lat= currentLocation!.latitude;
    widget.fieldLocation!.lng= currentLocation!.longitude;
    // currentLocation = myLocation;
    cameraPosition = CameraPosition(target: currentLocation!, zoom: 16.0);
    await Future.delayed(Duration(milliseconds: 200), () => setState(() {}));
    _defaultMarker();
  }

  void _defaultMarker() {
    handleMarker.add(Marker(
      markerId: MarkerId(currentLocation.toString()),
      position: currentLocation!,
    ));
  }

  void _handleTap(LatLng tappedPoint) {
    setState(() {
      handleMarker = [];
      widget.fieldLocation!.lat = tappedPoint.latitude;
      widget.fieldLocation!.lng = tappedPoint.longitude;
      handleMarker.add(
        Marker(
          markerId: MarkerId(tappedPoint.toString()),
          position: tappedPoint,
        ),
      );
      // print(fieldLocation);
    });
  }

  Widget buildMap() {
    return currentLocation != null
        ? GoogleMap(
            zoomGesturesEnabled: true,
            initialCameraPosition: cameraPosition!,
            onTap: _handleTap,
            mapType: MapType.normal,
            myLocationEnabled: true,
            myLocationButtonEnabled: true,
            markers: Set.from(handleMarker),
          )
        : CustomDialogLoading();
  }

  Widget buildSectionMap(BuildContext context) {
    return Container(
      width: sized(context).width,
      height: 300,
      color: Colors.white,
      child: buildMap(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          buildSectionMap(context),
          // ElevatedButton(
          //   child: Text('handle tapped point'),
          //   onPressed: () {
          //     // print(handleMarker);
          //     print("${fieldLocation.lat}${fieldLocation.lng}");
          //   },
          // ),
        ],
      ),
    );
  }
}
