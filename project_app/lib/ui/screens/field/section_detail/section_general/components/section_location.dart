import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:project_app/constants.dart';
import 'package:project_app/ui/components/title_form_field.dart';

// import 'package:cupertino_icons/';
import 'package:cupertino_icons/cupertino_icons.dart';
import 'package:project_app/ui/screens/field/components/title_bar.dart';

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
    getLatLng();
    super.initState();
  }

  void getLatLng() {
    if (widget.location != null) {
      String lctData = widget.location!;
      int index = lctData.indexOf(',');
      double lat = double.parse(lctData.substring(0, index));
      double lng = double.parse(lctData.substring(index + 1, lctData.length));
      setState(() => location = LatLng(lat, lng));
    }
  }

  Widget buildGoogleMap() {
    return GoogleMap(
      zoomGesturesEnabled: true,
      initialCameraPosition: CameraPosition(
        target: location!,
        zoom: 16.0,
      ),
      mapType: MapType.normal,
      myLocationButtonEnabled: true,
      markers: Set.from([
        Marker(
          markerId: MarkerId(location!.toString()),
          position: location!,
        )
      ]),
    );
  }

  Widget buildCardMap(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TitleBar(icon: Icons.location_pin, title: 'Location'),
          ),
          Padding(
            padding: EdgeInsets.only(left: 8.0, bottom: 8.0, right: 8.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Container(
                width: sized(context).width,
                height: 300,
                color: Colors.black12,
                child: widget.location != null
                    ? buildGoogleMap()
                    : Center(
                        child: Icon(
                          Icons.location_off,
                          color: Colors.black26,
                          size: sized(context).width * 0.4,
                        ),
                      ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return buildCardMap(context);
  }
}
