import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:project_app/core/models/Field.dart';
import 'package:project_app/ui/components/custom_dialog_loading.dart';
import 'package:project_app/ui/components/title_form_field.dart';

import '../../../../constants.dart';

class SectionLocation extends StatefulWidget {
  final Field? field;
  final LatLng? currentLct;

  const SectionLocation({
    Key? key,
    @required this.field,
    this.currentLct,
  }) : super(key: key);

  @override
  _SectionLocationState createState() => _SectionLocationState();
}

class _SectionLocationState extends State<SectionLocation> {
  List<Marker> handleMarker = [];
  Location location = Location();
  CameraPosition? cameraPosition;
  LatLng? currentLct;

  @override
  void initState() {
    print('from main: ${widget.currentLct}');
    super.initState();
  }

  Future getCurrentLct() async {
    LocationData lct = await getCurrentLocation();
    LatLng _currentLct = LatLng(lct.latitude!, lct.longitude!);
    await Future.delayed(Duration(milliseconds: 300));
    currentLct = _currentLct;
  }

  void _handleTap(LatLng tappedPoint) {
    setState(() {
      handleMarker = [];
      String _location = '${tappedPoint.latitude},${tappedPoint.longitude}';
      handleMarker.add(
        Marker(
          draggable: true,
          markerId: MarkerId(tappedPoint.toString()),
          position: tappedPoint,
        ),
      );
      widget.field!.location = _location;
    });
    print(widget.field);
  }

  void setCameraPosition(LatLng location) {
    cameraPosition = CameraPosition(
      target: currentLct!,
      zoom: 16,
    );
  }

  Future<bool> setCurrentLct() async {
    widget.field!.location != null
        ? currentLct = decodeLct(widget.field!.location!)
        : await getCurrentLct();
    setCameraPosition(currentLct!);
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Container(
        width: sized(context).width,
        height: 450,
        color: Colors.white,
        child: Column(
          children: [
            TitleFormField(
              iconData: Icons.location_pin,
              title: 'โลเคชั่นสนาม',
            ),
            Expanded(
              child: FutureBuilder(
                future: setCurrentLct(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Padding(
                      padding:
                          EdgeInsets.only(left: 8.0, right: 8.0, bottom: 8.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: GoogleMap(
                          initialCameraPosition: cameraPosition!,
                          onTap: _handleTap,
                          mapType: MapType.normal,
                          myLocationEnabled: true,
                          zoomGesturesEnabled: true,
                          myLocationButtonEnabled: true,
                          markers: Set.from(handleMarker),
                        ),
                      ),
                    );
                  } else {
                    return CustomDialogLoading();
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
