import 'package:flutter/material.dart';
import 'package:project_app/ui/screens/test/components/search.dart';
import 'body.dart';

class TextScreen extends StatefulWidget {
  const TextScreen({Key? key}) : super(key: key);

  @override
  _TextScreenState createState() => _TextScreenState();
}
class _TextScreenState extends State<TextScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SearchScreen(),
      // body: LaunchUrl(),
      // body: Body(),
    );
  }
}
