import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_app/core/apis/TimeApi.dart';
import 'package:project_app/core/models/Time.dart';
import 'package:project_app/core/models/User.dart';
import 'package:project_app/core/services/TimeService.dart';
import 'package:project_app/core/services/UserService.dart';
import 'package:project_app/ui/screens/club/components/dialogTimePicker/dialog_time_picker.dart';
import 'package:project_app/ui/screens/club/components/sectionTime/card_time.dart';
import 'package:project_app/ui/screens/club/components/sectionTime/dialog_booking.dart';
import 'package:project_app/ui/screens/club/components/sectionTime/dialog_info.dart';

import '../../../../../constants.dart';
import 'dialog_remove.dart';

class SectionTime extends StatefulWidget {
  final bool isOwner;
  final bool status;
  final int fieldId;

  const SectionTime({
    Key key,
    @required this.isOwner,
    @required this.status,
    @required this.fieldId,
  }) : super(key: key);

  @override
  _SectionTimeState createState() => _SectionTimeState();
}

class _SectionTimeState extends State<SectionTime> {
  List<Time> times = List<Time>();
  double sizedAnimatedCon;

  @override
  void initState() {
    fetchData();
    super.initState();
  }

  Future<void> _onRemoveTime(int index) async {
    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) =>
          DialogRemove(
            isOk: () async {
              if (await TimeService.delete(id: times[index].id)) {
                await fetchData();
                Navigator.pop(context);
              } else {
                print('Remove Fail');
              }
            },
          ) ??
          fetchData(),
    );
  }

  Future _onAddTime({@required BuildContext context}) async {
    await showDialog(
          context: context,
          builder: (context) => DialogTimePicker(
            fieldId: widget.fieldId,
          ),
        ) ??
        await fetchData();
  }

  Widget buttonAddTime() => widget.isOwner
      ? ClipRRect(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(10),
            bottomRight: Radius.circular(10),
          ),
          child: Material(
            color: creamPrimaryColor,
            child: InkWell(
              onTap: () async => _onAddTime(context: context),
              child: Container(
                width: sized(context).width * 0.9,
                height: 42,
                child: Center(
                  child: Icon(Icons.add),
                ),
              ),
            ),
          ),
        )
      : Container(
          width: sized(context).width * 0.9,
          height: 10,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10),
            ),
            color: creamPrimaryColor,
          ),
        );

  Widget listSection({@required BuildContext context}) => Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ...List.generate(
            times.length,
            (index) => sectionTime(index: index),
          ),
        ],
      );

  CardTime sectionTime({@required int index}) => CardTime(
        isOwner: widget.isOwner,
        time: times[index],
        onActiveIcon: () async => await _onActiveIcon(index),
        onBooking: () async => times[index].status ? () {} : _onBooking(index),
        onRemoveTime: () async => _onRemoveTime(index),
        onInfo: () async => await _onInfo(index),
      );

  Future<void> _onInfo(int index) async {
    int userId = times[index].userId;
    User _user =
        userId != 0 ? await UserService.getById(userId: userId) : User();
    showDialog(
      context: context,
      builder: (context) => DialogInfo(user: _user),
    );
  }

  Future<void> _onActiveIcon(int index) async {
    var response = await TimeNetwork.changeStatus(timeId: times[index].id);
    print(response);
    fetchData();
  }

  Future _onBooking(int index) async {
    widget.isOwner
        ? print('is a owner')
        : await showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) => DialogBooking(
                onBooking: () async {
                  await TimeService.booking(timeId: times[index].id);
                  Navigator.pop(context);
                },
              ),
            ) ??
            fetchData();
  }

  Future<void> fetchData() async {
    times = await TimeService.getByFieldId(fieldId: widget.fieldId);
    await Future.delayed(Duration(milliseconds: 300), () => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      width: sized(context).width * 0.9,
      height: (widget.status)
          ? (widget.isOwner ? 50 : 10) + 50 * times.length.toDouble()
          : 0,
      duration: Duration(milliseconds: 100),
      child: SingleChildScrollView(
        child: Column(
          children: [
            listSection(context: context),
            buttonAddTime(),
          ],
        ),
      ),
    );
  }
}
