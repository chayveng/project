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
    // getLatLng('16.4889132,102.8447655');
    getLatLng(widget.location!);
    super.initState();
  }

  void getLatLng(String lctData) {
    int index = lctData.indexOf(',');
    double lat = double.parse(lctData.substring(0, index));
    double lng = double.parse(lctData.substring(index + 1, lctData.length));
    setState(() => location = LatLng(lat, lng));
  }

  @override
  Widget build(BuildContext context) {
    // return buildCardMap(context);
    return widget.location != null ? buildCardMap(context) : SizedBox();
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
