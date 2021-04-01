import 'package:flutter/material.dart';
import 'package:project_app/constants.dart';
import 'package:project_app/core/apis/Network/TimeNetwork.dart';
import 'package:project_app/core/models/Time.dart';
import 'package:project_app/core/services/TimeService.dart';

class CardTime extends StatelessWidget {
  final bool isOwner;
  final Time time;

   CardTime({
    Key key,
    @required this.isOwner,
    @required this.time,
  }) : super(key: key);

  bool _status = false;
  @override
  Widget build(BuildContext context) {
    return Material(
      child: InkWell(
        onTap: () {
          print('tap on card time');

        },
        child: Container(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                time.status ? Icons.album : Icons.album_outlined,
                color: time.status ? Colors.redAccent : Colors.lightGreenAccent,
              ),
              Expanded(
                child: Text(
                  '${time.startTime} - ${time.endTime}',
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
              ),
              isOwner
                  ? IconButton(
                      icon: Icon(Icons.remove_circle_outline_rounded),
                      onPressed: () async {
                        var res = await TimeService.delete(id: time.id);
                        var resTime = await TimeNetwork.delete(id: time.id);
                        print(resTime);
                        print(res);
                        // showDialog(
                        //     context: context,
                        //     builder: (context) => DialogConfirm(timeId: time.id,));
                      },
                    )
                  : SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}

class DialogConfirm extends StatefulWidget {
  final timeId;

  const DialogConfirm({Key key,@required this.timeId}) : super(key: key);

  @override
  _DialogConfirmState createState() => _DialogConfirmState(timeId);
}

class _DialogConfirmState extends State<DialogConfirm> {
  final timeId;

  _DialogConfirmState(this.timeId);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        width: sized(context).width,
        height: 200,
        child: RaisedButton(
          onPressed: () async {
            print(timeId);
            var response = await TimeService.delete(id: timeId);
            print(response);
            setState(() {});
          },
        ),
      ),
    );
  }
}
