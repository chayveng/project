import 'package:flutter/material.dart';
import 'package:project_app/ui/components/rounded_button.dart';
import 'package:url_launcher/url_launcher.dart';

class Launch extends StatefulWidget {
  const Launch({Key? key}) : super(key: key);

  @override
  _LaunchState createState() => _LaunchState();
}

class _LaunchState extends State<Launch> {
  String _launchUrl = 'https://www.google.com';

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 100,
          height: 100,
          child: RoundedButton(
            text: 'ddddd',
            onTap: () {
              _launchInBrowser(_launchUrl);
            },
          ),
        ),
        Container(
          width: 100,
          height: 100,
          child: RoundedButton(
            text: 'drjgoeogj',
            onTap: () {
              _launchInApp(_launchUrl);
            },
          ),
        ),
      ],
    );
  }

  Future<void> _launchInBrowser(String url) async {
    print('ok');
    if (await canLaunch(url)) {
      print('go');
      await launch(
        url,
        forceSafariVC: false,
        forceWebView: false,
      headers: <String, String>{'header_key': 'header_value'});
    } else {
      print('nnn');
      throw 'Could not launch $url';
    }
  }

  Future<void> _launchInApp(String url) async {
    if (await canLaunch(url)) {
      await launch(url,
          forceSafariVC: true,
          forceWebView: true,
          headers: <String, String>{'header_key': 'header_value'});
    } else {
      throw 'Could not launch $url';
    }
  }
}



