import 'package:flutter/material.dart';
import 'package:project_app/ui/screens/field/section_times/components/dialog_info.dart';

import '../../../../../constants.dart';

class CardTime extends StatelessWidget {
  final String? date;
  final String? startTime;
  final String? endTime;
  final bool? isOwner;

  const CardTime({
    Key? key,
    this.date,
    this.startTime,
    this.endTime,
    this.isOwner,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: sized(context).height * 0.08,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: whiteColor,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            buildDate(),
            buildTime(),
            buildButtonInfo(context),
          ],
        ),
      ),
    );
  }

  Widget buildButtonInfo(BuildContext context) {
    return isOwner!
        ? IconButton(
            icon: Icon(Icons.info_outline_rounded),
            onPressed: () => _onInfo(context),
          )
        : SizedBox();
  }

  Text buildTime() {
    return Text(
      '${startTime!} - ${endTime!}',
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Row buildDate() {
    return Row(
      children: [
        Icon(
          Icons.event_busy,
          color: Colors.pink,
          size: 24.0,
        ),
        SizedBox(width: 8),
        Text(
          date!,
          style: TextStyle(fontSize: 18),
        ),
      ],
    );
  }

  _onInfo(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => DialogInfo(),
      // builder: (context) => DialogInfo(user: _user),
    );
  }
}
