import 'package:flutter/material.dart';
import 'package:project_app/constants.dart';

class CustomTabBar extends StatelessWidget {
  final String? tabBar;
  final bool? current;

  const CustomTabBar({Key? key, this.tabBar, this.current}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Container(
            child: Text(tabBar!),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: sized(context).width * 0.1,
          ),
          child: Container(
            height: 5,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: current! ? orangeColor : Colors.transparent,
            ),
          ),
        ),
      ],
    );
  }
}
