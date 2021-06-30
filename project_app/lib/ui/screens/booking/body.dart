import 'package:flutter/material.dart';
import 'package:project_app/constants.dart';
import 'package:project_app/ui/screens/booking/components/card_time.dart';
import 'package:url_launcher/url_launcher.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  double lat = 16.4762971, lng = 102.8822091;

  Future<void> _launchMap() async {
    print('go');
    String url = 'https://map.google.com/maps/search/?api=1&query=$lat,$lng';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }


  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          CardTime(
            onTapMap: () {
              _launchMap();
            },
          ),
        ],
      ),
    );
  }
}
