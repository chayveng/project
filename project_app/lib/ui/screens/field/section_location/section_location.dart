import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:project_app/constants.dart';
import 'package:project_app/ui/components/title_form_field.dart';

class SectionLocation extends StatefulWidget {
  final String? location;

  const SectionLocation({
    Key? key,
    @required this.location,
  }) : super(key: key);

  @override
  _SectionLocationState createState() => _SectionLocationState();
}

class _SectionLocationState extends State<SectionLocation> {
  LatLng? location;

  @override
  void initState() {
    // getLatLng('16.32423,106.3435');
    getLatLng(widget.location);
    super.initState();
  }

  void getLatLng(String? lctData) {
    print(widget.location);
    String defaultLct = '16.34543,106.43535';
    if(lctData != null){
      defaultLct = lctData;
    }
    int index = defaultLct.indexOf(',');
    double lat = double.parse(defaultLct.substring(0, index));
    double lng = double.parse(defaultLct.substring(index + 1, defaultLct.length));
    setState(() => location = LatLng(lat, lng));
  }

  @override
  Widget build(BuildContext context) {
    return buildCardMap(context);
    // return widget.location != null ? buildCardMap(context) : SizedBox();
  }

  Widget buildCardMap(BuildContext context) {
    return Container(
      child: Column(
        children: [
          buildTitle(),
          Container(
            width: sized(context).width,
            height: 300,
            child: buildGoogleMap(),
          ),
        ],
      ),
    );
  }

  GoogleMap buildGoogleMap() {
    return GoogleMap(
      zoomGesturesEnabled: true,
      initialCameraPosition: CameraPosition(
        target: location!,
        zoom: 16.0,
      ),
      mapType: MapType.normal,
      // myLocationEnabled: true,
      myLocationButtonEnabled: true,
      markers: Set.from([
        Marker(
          markerId: MarkerId(location!.toString()),
          position: location!,
        )
      ]),
    );
  }

  Widget buildTitle() {
    return TitleFormField(iconData: Icons.location_pin, title: 'Location');
  }
}
