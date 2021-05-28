import 'package:flutter/material.dart';

class CustomTabBar extends StatelessWidget {
  final String tabBar;
  final bool current;

  const CustomTabBar({Key key, this.tabBar, this.current}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Container(
            child: Text(tabBar),
          ),
        ),
        Container(
          height: 2,
          color: current ? Colors.black87 : Colors.black12,
        ),
      ],
    );
  }
}
