import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_app/constants.dart';
import 'package:project_app/ui/screens/field/section_times/components/card_select_time.dart';
import 'package:project_app/ui/screens/field/section_times/components/dialog_time_picker.dart';

class FormBooking extends StatefulWidget {
  const FormBooking({Key? key}) : super(key: key);

  @override
  _FormBookingState createState() => _FormBookingState();
}

class _FormBookingState extends State<FormBooking> {
  DateTime? startTime;
  DateTime? endTime;

  DateTime start = DateTime.parse('2021-07-03 11:44');
  DateTime end = DateTime.parse('2021-07-03 15:50');

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          buildFormSelectTime(),
          buildBookBtn(),
        ],
      ),
    );
  }

  onBook() async {
    print(startTime);
    print(endTime);
  }

  onStartTime() async {
    DateTime? _dateTime = await showDialog(
      context: context,
      builder: (context) => DialogTimePicker(dateTime: startTime),
    );
    if (_dateTime != null) {
      setState(() {
        startTime = _dateTime;
      });
      print(startTime);
    }
  }

  onEndTime() async {
    // showModalBottomSheet(
    //     context: context,
    //     builder: (context) {
    //       return Column(
    //         mainAxisSize: MainAxisSize.min,
    //         children: <Widget>[
    //           ListTile(
    //             leading: new Icon(Icons.photo),
    //             title: new Text('Photo'),
    //             onTap: () {
    //               Navigator.pop(context);
    //             },
    //           ),
    //           ListTile(
    //             leading: new Icon(Icons.music_note),
    //             title: new Text('Music'),
    //             onTap: () {
    //               Navigator.pop(context);
    //             },
    //           ),
    //           ListTile(
    //             leading: new Icon(Icons.videocam),
    //             title: new Text('Video'),
    //             onTap: () {
    //               Navigator.pop(context);
    //             },
    //           ),
    //           ListTile(
    //             leading: new Icon(Icons.share),
    //             title: new Text('Share'),
    //             onTap: () {
    //               Navigator.pop(context);
    //             },
    //           ),
    //         ],
    //       );
    //     });
    DateTime? _dateTime = await showDialog(
      context: context,
      builder: (context) => DialogTimePicker(dateTime: endTime),
    );
    if (_dateTime != null) {
      setState(() {
        endTime = _dateTime;
      });
      print(endTime);
    }
  }

  Padding buildBookBtn() {
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: InkWell(
        onTap: onBook,
        child: Container(
          width: 180,
          height: 35,
          decoration: BoxDecoration(
            color: orangePrimaryColor,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(child: Text('Book')),
        ),
      ),
    );
  }

  Row buildFormSelectTime() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CardSelectTime(
            defaultStr: 'start', dateTime: startTime, onTap: onStartTime),
        buildTo(),
        CardSelectTime(defaultStr: 'end', dateTime: endTime, onTap: onEndTime),
      ],
    );
  }

  Padding buildTo() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Text('ถึง'),
    );
  }
}
