import 'package:flutter/material.dart';
import 'package:project_app/constants.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:async';

class LaunchUrl extends StatefulWidget {
  @override
  _LaunchUrlState createState() => _LaunchUrlState();
}

class _LaunchUrlState extends State<LaunchUrl> {
  Future<void>? _launched;
  String _launchUrl = 'https://www.google.com/';
  String map_api = 'API_KEY';
  double lat = 16.4762971, lng = 102.8822091;

  Future<void> _launchInBrowser(String url) async {
    if (await canLaunch(url)) {
      await launch(
        url,
        forceSafariVC: false,
        forceWebView: false,
        headers: <String, String>{'header_key': 'header_value'},
      );
    } else {
      throw 'Could not launch $url';
    }
  }

  Future<void> _launchInApp(String url) async {
    if (await canLaunch(url)) {
      await launch(
        url,
        forceSafariVC: true,
        forceWebView: true,
        headers: <String, String>{'header_key': 'header_value'},
      );
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        width: sized(context).width,
        height: sized(context).height,
        color: Colors.pink,
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () async {
                print('go');
                String url =
                    'https://map.google.com/maps/search/?api=1&query=$lat,$lng';
                if (await canLaunch(url)) {
                  await launch(url);
                } else {
                  throw 'Could not launch $url';
                }
              },
              child: Text('launch in browser'),
            ),
            ElevatedButton(
              onPressed: () async {
                print('go');
                _launchInApp(_launchUrl);
              },
              child: Text('launch in App'),
            ),
          ],
        ),
      ),
    );
  }
}
