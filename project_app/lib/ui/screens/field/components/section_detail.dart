import 'package:flutter/material.dart';
import 'package:project_app/constants.dart';
import 'package:project_app/ui/screens/field/components/custom_tabBar.dart';
import 'package:project_app/ui/screens/field/components/section_general.dart';
import 'package:project_app/ui/screens/field/components/section_time.dart';

class SectionDetail extends StatefulWidget {
  const SectionDetail({Key key}) : super(key: key);

  @override
  _SectionDetailState createState() => _SectionDetailState();
}

class _SectionDetailState extends State<SectionDetail> {
  int _currentState = 0;
  List<String> tabBars = ['General', 'Times'];
  List<Widget> tabViews = [SectionGeneral(), SectionTimes()];

  void _onTapCurrent(int index) {
    setState(() {
      _currentState = tabBars.indexOf(tabBars[index]);
    });
  }

  Widget buildDetail(BuildContext context) {
    return Container(
      width: sized(context).width,
      child: Center(
        child: tabViews[_currentState],
      ),
    );
  }

  Widget buildTabBars() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ...List.generate(
          tabBars.length,
          (index) {
            return Expanded(
              child: InkWell(
                onTap: () => _onTapCurrent(index),
                child: CustomTabBar(
                  tabBar: tabBars[index],
                  current: _currentState == index ? true : false,
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        buildTabBars(),
        buildDetail(context),
      ],
    );
  }
}
