import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:project_app/core/models/Club.dart';
import 'package:project_app/core/models/Field.dart';
import 'package:project_app/core/models/Time.dart';
import 'package:project_app/core/services/ClubService.dart';
import 'package:project_app/core/services/FieldServices.dart';
import 'package:project_app/ui/screens/club/components/sectionFieldTime/section_field_time.dart';
import 'package:project_app/ui/screens/club/components/sectionImage/section_image.dart';
import 'package:project_app/ui/screens/createField/create_field.dart';

import '../../../../constants.dart';
import 'button_add_field.dart';

class Body extends StatefulWidget {
  final int clubId;
  final bool isOwner;

  Body({Key key, this.clubId, this.isOwner}) : super(key: key);

  @override
  _BodyState createState() => _BodyState(clubId, isOwner);
}

class _BodyState extends State<Body> {
  final int clubId;
  final bool isOwner;
  Club club = new Club();
  List<Field> fields = new List<Field>();
  List<Time> times = new List<Time>();

  _BodyState(this.clubId, this.isOwner);

  @override
  void initState() {
    fetchData();
    Future.delayed(Duration(milliseconds: 500), () => setState(() {}));
    super.initState();
  }

  onGoBlack() {
    setState(() {});
  }

  Future<bool> fetchData() async {
    club = await ClubService.getById(id: clubId);
    fields = await FieldServices.getFieldClubId(club.id);
    await Future.delayed(Duration(milliseconds: 1000));
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: fetchData(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SectionImage(
                  isOwner: isOwner,
                  club: club,
                ),
                ...List.generate(
                  (fields == null) ? 0 : fields.length,
                  (index) {
                    return SectionFieldTime(
                      isOwner: isOwner,
                      field: fields[index],
                    );
                    // return Stack(
                    //   children: [
                    //     Column(
                    //       children: [
                    //         CardField(
                    //           field: fields[index],
                    //           onTap: () {
                    //             print('onTap');
                    //             showDialog(
                    //               context: context,
                    //               barrierDismissible: true,
                    //               builder: (context) {
                    //                 return DialogTimes(
                    //                   fieldId: fields[index].id,
                    //                   isOwner: isOwner,
                    //                 );
                    //               },
                    //             );
                    //           },
                    //         ),
                    //       ],
                    //     ),
                    //     isOwner
                    //         ? OwnerButton(
                    //             onClose: () async => await _onRemove(index),
                    //             onEdit: () => _onEdit(context, index),
                    //           )
                    //         : SizedBox(),
                    //   ],
                    // );
                  },
                ),
                SizedBox(height: 10),
                ButtonAddField(isOwner: isOwner, club: club),
              ],
            ),
          );
        } else {
          return SpinKitWave(
            color: orangePrimaryColor,
            size: 40,
          );
        }
      },
    );
  }

  void _onEdit(BuildContext context, int index) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CreateField(
          fieldId: fields[index].id,
          clubId: club.id,
          isCreate: true,
        ),
      ),
    );
  }

  Future _onRemove(int index) async {
    print('close');
    var res = await FieldServices.delete(id: fields[index].id);
    if (res) {
      await fetchData();
      setState(() {});
    } else {
      print('Fail');
    }
  }
}

class OwnerButton extends StatelessWidget {
  final GestureTapCallback onClose;
  final GestureTapCallback onEdit;

  const OwnerButton({
    Key key,
    this.onClose,
    this.onEdit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        GestureDetector(
          onTap: onEdit,
          child: Icon(
            Icons.edit,
            size: 20,
          ),
        ),
        GestureDetector(
          onTap: onClose,
          child: Icon(Icons.close),
        ),
      ],
    );
  }
}
