import 'package:flutter/material.dart';
import 'package:project_app/constants.dart';
import 'package:project_app/core/models/Field.dart';
import 'package:project_app/core/models/Time.dart';
import 'package:project_app/core/services/TimeService.dart';
import 'package:project_app/ui/screens/field/components/custom_tabBar.dart';
import 'package:project_app/ui/screens/field/components/section_general.dart';
import 'package:project_app/ui/screens/field/components/section_time.dart';

class SectionDetail extends StatefulWidget {
  final List<String> tabBars;
  final List<Widget> tabViews;

  const SectionDetail({Key key, this.tabBars, this.tabViews}) : super(key: key);

  @override
  _SectionDetailState createState() => _SectionDetailState();
}

class _SectionDetailState extends State<SectionDetail> {
  int _currentState = 0;


  @override
  void initState() {
    fetchData();
    super.initState();
  }

  Future<void> fetchData() async {
  }

  void _onTapCurrent(int index) {
    setState(() {
      _currentState = widget.tabBars.indexOf(widget.tabBars[index]);
    });
  }

  Widget buildDetail(BuildContext context) {
    return Container(
      color: creamPrimaryColor,
      width: sized(context).width,
      child: Center(
        child: widget.tabViews[_currentState],
      ),
    );
  }

  Widget buildTabBars() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ...List.generate(
          widget.tabBars.length,
          (index) {
            return Expanded(
              child: InkWell(
                onTap: () => _onTapCurrent(index),
                child: CustomTabBar(
                  tabBar: widget.tabBars[index],
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
