import 'package:flutter/material.dart';

class CustomColon extends StatelessWidget {
  final double? size;
  const CustomColon({Key? key, this.size}) : super(key: key);
  Widget buildDot(){
    return Container(
      width: size!,
      height: size!,
      decoration: BoxDecoration(
        color: Colors.black,
        shape: BoxShape.circle,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        buildDot(),
        buildDot(),
      ],
    );
  }
}
