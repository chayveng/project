import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_app/core/models/Time.dart';
import 'package:project_app/core/services/TimeService.dart';
import 'package:project_app/ui/screens/club/components/dialogTimePicker/dialog_time_picker.dart';
import 'package:project_app/ui/screens/club/components/sectionTime/card_time.dart';

import '../../../../../constants.dart';

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
      builder: (context) =>
          DialogConfirmRemoveTime(
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
      ? IconButton(
          icon: Icon(Icons.add),
          onPressed: () async => _onAddTime(context: context),
        )
      : SizedBox();

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
        onTap: () {
          print('is on tap');
        },
        onRemoveTime: () async => _onRemoveTime(index),
      );

  Future<void> fetchData() async {
    times = await TimeService.getByFieldId(fieldId: widget.fieldId);
    await Future.delayed(Duration(milliseconds: 300), () => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      width: sized(context).width,
      height: (widget.status)
          ? (widget.isOwner ? 50 : 0) + 50 * times.length.toDouble()
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

class DialogConfirmRemoveTime extends StatelessWidget {
  final int fieldId;
  final int timeId;
  final VoidCallback isOk;

  const DialogConfirmRemoveTime({
    Key key,
    @required this.isOk,
    this.fieldId,
    this.timeId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        width: sized(context).width,
        height: 200,
        child: RaisedButton(
          child: Text('Confirm'),
          onPressed: isOk,
        ),
      ),
    );
  }
}
