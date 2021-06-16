import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:project_app/core/models/Field.dart';
import 'package:project_app/ui/components/custom_dialog_loading.dart';
import 'package:project_app/ui/components/title_form_field.dart';

import '../../../../constants.dart';

class SectionLocation extends StatefulWidget {
  final Field? field;

  const SectionLocation({
    Key? key,
    @required this.field,
  }) : super(key: key);

  @override
  _SectionLocationState createState() => _SectionLocationState();
}

class _SectionLocationState extends State<SectionLocation> {
  // LatLng myLocation = LatLng(16.431387560289423, 102.81499053196279);
  List<Marker> handleMarker = [];
  Location location = Location();
  CameraPosition? cameraPosition;
  LatLng? currentLocation;

  @override
  void initState() {
    // setLocation();
    super.initState();
  }

  Future<bool> setLocation() async {
    if (widget.field!.location != null) {
      print('not null');
      currentLocation = getLatLng(widget.field!.location!);
      print(currentLocation);
    } else {
      print('null');
      LocationData lctLocation = await location.getLocation();
      currentLocation = LatLng(lctLocation.latitude!, lctLocation.longitude!);
      print(currentLocation);
    }
    // if (widget.field!.location != null) {
    //   print('lat lng null');
    //   LocationData lctLocation = await location.getLocation();
    //   currentLocation = LatLng(lctLocation.latitude!, lctLocation.longitude!);
    //   print(currentLocation);
    // } else if (widget.field!.location == 0) {
    //   print('lat lng 0.0');
    //   LocationData lctLocation = await location.getLocation();
    //   currentLocation = LatLng(lctLocation.latitude!, lctLocation.longitude!);
    //   print(currentLocation);
    // }
    // else {
    //   print('Have');
    //   currentLocation = getLatLng(widget.field!.location!);
    // currentLocation = LatLng(widget.field!.lat!, widget.field!.lng!);
    // _defaultMarker();
    // }
    // print('set Finish');
    cameraPosition = CameraPosition(target: currentLocation!, zoom: 16.0);
    await Future.delayed(Duration(milliseconds: 500));
    return false;
  }

  LatLng getLatLng(String location) {
    int index = location.indexOf(',');
    double lat = double.parse(location.substring(0, index));
    double lng = double.parse(location.substring(index + 1, location.length));
    return LatLng(lat, lng);
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
      String _location = '${tappedPoint.latitude},${tappedPoint.longitude}';
      print(_location);
      widget.field!.location = _location;
      // widget.field!.lat = tappedPoint.latitude;
      // widget.field!.lng = tappedPoint.longitude;
      handleMarker.add(
        Marker(
          markerId: MarkerId(tappedPoint.toString()),
          position: tappedPoint,
        ),
      );
      // print(fieldLocation);
    });
  }

  Widget sectionMap() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Container(
        width: sized(context).width,
        height: 300,
        color: creamPrimaryColor,
        child: Column(
          children: [
            TitleFormField(
              iconData: Icons.location_pin,
              title: 'Location',
            ),
            Expanded(
              child: GoogleMap(
                zoomGesturesEnabled: true,
                initialCameraPosition: cameraPosition!,
                onTap: _handleTap,
                mapType: MapType.normal,
                myLocationEnabled: true,
                myLocationButtonEnabled: true,
                markers: Set.from(handleMarker),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: setLocation(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          return sectionMap();
        } else {
          return CustomDialogLoading();
        }
      },
    );
  }
}
