import 'package:flutter/material.dart';

class CustomColon extends StatelessWidget {
  const CustomColon({Key? key}) : super(key: key);

  Widget buildColon() {
    return Container(
      height: 50,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 3),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            buildDot(),
            SizedBox(height: 5),
            buildDot(),
          ],
        ),
      ),
    );
  }

  Container buildDot() {
    return Container(
      width: 4,
      height: 4,
      decoration: BoxDecoration(color: Colors.black87, shape: BoxShape.circle),
    );
  }

  @override
  Widget build(BuildContext context) {
    return buildColon();
  }
}
