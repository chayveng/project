import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class UrlLauncher extends StatefulWidget {
  const UrlLauncher({Key? key}) : super(key: key);

  @override
  _UrlLauncherState createState() => _UrlLauncherState();
}

class _UrlLauncherState extends State<UrlLauncher> {

  Future<void> openMap(double lat, double lng)async{
    String googleUrl = 'https://www.google.com/maps/search/?api=1&query=$lat,$lng';
    if (await canLaunch(googleUrl)) {
      await launch(googleUrl, forceWebView: false);
    }else{
      throw "Could not open the map.";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text('url launcher'),
          ElevatedButton(
            onPressed: () async{
              print('go to map');
              // openMap(16.3754752, 102.7941366);
              // openMap(16.4329489,102.8257675); // CentralPlaza
             await openMap(16.4315216,102.8152532); // KingKing P
            },
            child: Text('go to map'),
          ),

        ],
      ),
    );
  }
}
