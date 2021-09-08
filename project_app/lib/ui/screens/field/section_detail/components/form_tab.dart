import 'package:flutter/material.dart';
import 'package:project_app/constants.dart';
import 'package:project_app/ui/screens/field/components/custom_tabBar.dart';

class FormTab extends StatefulWidget {
  final List<String>? tabBars;
  final List<Widget>? tabViews;

  const FormTab({Key? key, this.tabBars, this.tabViews}) : super(key: key);

  @override
  _FormTabState createState() => _FormTabState();
}

class _FormTabState extends State<FormTab> {
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
      _currentState = widget.tabBars!.indexOf(widget.tabBars![index]);
    });
  }

  Widget buildDetail(BuildContext context) {
    return Container(
      width: sized(context).width,
      child: Center(
        child: widget.tabViews![_currentState],
      ),
    );
  }

  Widget buildTabBars() {
    return Container(
      padding: EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
          color: Colors.white,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ...List.generate(
            widget.tabBars!.length,
            (index) {
              return Expanded(
                child: InkWell(
                  onTap: () => _onTapCurrent(index),
                  child: CustomTabBar(
                    tabBar: widget.tabBars![index],
                    current: _currentState == index ? true : false,
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          buildTabBars(),
          buildDetail(context),
        ],
      ),
    );
  }
}
