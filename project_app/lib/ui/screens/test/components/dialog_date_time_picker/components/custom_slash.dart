import 'package:flutter/material.dart';

class CustomSlash extends StatelessWidget {
  const CustomSlash({Key? key}) : super(key: key);

  Widget buildSlash() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Container(width: 10, height: 3, color: Colors.black87),
    );
  }

  @override
  Widget build(BuildContext context) {
    return buildSlash();
  }
}
