import 'package:flutter/material.dart';
import 'package:project_app/constants.dart';

class CustomTabBar extends StatelessWidget {
  final String tabBar;
  final bool current;

  const CustomTabBar({Key key, this.tabBar, this.current}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: navyPrimaryColor,
      // color: current ? navyPrimaryColor : Colors.transparent,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 18),
            child: Container(
              child: Text(
                tabBar,
                style: TextStyle(
                  color: current ? orangePrimaryColor : Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Container(
            height: 5,
            color: current ? orangePrimaryColor : navyPrimaryColor,
          ),
        ],
      ),
    );
  }
}
