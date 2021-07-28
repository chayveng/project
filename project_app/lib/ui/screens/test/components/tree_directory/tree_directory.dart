import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_app/constants.dart';

class TreeDirectory extends StatelessWidget {
  TreeDirectory({Key? key}) : super(key: key);
  final List data1 = [];
  final Color on = Colors.red;
  final Color off = Colors.red;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(50),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildItem('project_app'),
          Expanded(
            child: Column(
              children: [
                ...List.generate(
                  data1.length,
                      (index) {
                        print(index);
                    if (index != data1.length) {
                      return item(data1[index].toString(), 1, 1, 0, 1, 20);
                    } else if(index == data1.length){
                      return item(data1[index].toString(), 1, 0, 0, 1, 20);
                    }else{
                      return SizedBox();
                    }
                  },
                ),
              ],
            ),
          ),
          // item('assets', 1, 1, 0, 1, 20),
          // item('lib', 1, 1, 0, 1, 20),
          // item('lib', 1, 0, 0, 1, 20),
        ],
      ),
    );
  }

  Row item(String str, int top, int bottom, int left, int right,
      double fontSize) {
    return Row(
      children: [
        Container(
          child: Stack(
            alignment: Alignment.center,
            children: [
              Column(
                children: [
                  Container(width: 1, height: 11, color: top == 1 ? on : off),
                  Container(
                      width: 1, height: 11, color: bottom == 1 ? on : off),
                ],
              ),
              Row(
                children: [
                  Container(width: 11, height: 1, color: left == 1 ? on : off),
                  Container(width: 11, height: 1, color: right == 1 ? on : off),
                ],
              ),
            ],
          ),
        ),
        buildItem(str),
      ],
    );
  }

  Container buildItem(String str) {
    return Container(
      child: Row(
        children: [
          Icon(Icons.folder, size: 22),
          SizedBox(width: 4),
          Text(str),
        ],
      ),
    );
  }
}
