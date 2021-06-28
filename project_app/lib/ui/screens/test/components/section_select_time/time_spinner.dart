import 'package:flutter/material.dart';

class TimeSpinner extends StatefulWidget {
  final List? lst;
  final int? time;

  const TimeSpinner({Key? key, @required this.lst, this.time})
      : super(key: key);

  @override
  _TimeSpinnerState createState() => _TimeSpinnerState();
}

class _TimeSpinnerState extends State<TimeSpinner> {
  int? _currentIndex = 0;


  String setForm(int value) {
    String str = value.toString();
    if (str.length < 2) {
      return "0$str";
    } else {
      return str;
    }
  }

  PageView timeSpinner() {
    return PageView.builder(
      controller: PageController(viewportFraction: 0.3),
      scrollDirection: Axis.vertical,
      itemCount: widget.lst!.length,
      onPageChanged: (index) {
        // int isTime = int.parse(widget.lst![index]);
        // print(widget.lst![index]);
        print(index);
        setState(() {
           _currentIndex = index;
        });
      },
      itemBuilder: (context, index) => Center(
        child: Text(
          setForm(widget.lst![index]),
          style: TextStyle(
            fontSize: 24,
            color: index != _currentIndex ? Colors.black45 : Colors.black,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return timeSpinner();
  }
}
