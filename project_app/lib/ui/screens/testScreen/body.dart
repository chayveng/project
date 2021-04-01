import 'package:flutter/material.dart';
import 'package:project_app/core/models/Club.dart';
import 'package:project_app/core/models/Field.dart';
import 'package:project_app/core/services/ClubService.dart';
import 'package:project_app/core/services/FieldServices.dart';
import 'package:project_app/ui/components/rounded_button.dart';
import 'package:project_app/ui/screens/createField/create_field.dart';

class Body extends StatefulWidget {
  final int clubId;
  final bool isOwner;

  Body({Key key, this.clubId, this.isOwner}) : super(key: key);

  @override
  _BodyState createState() => _BodyState(1, true);
}

class _BodyState extends State<Body> {
  final int clubId;
  final bool isOwner;
  Club club = new Club();
  List<Field> fields = new List<Field>();

  _BodyState(this.clubId, this.isOwner);

  @override
  void initState() {
    // print('userId: $clubId');
    // fetchClub();
    // print(club);
    // fetchFields();
    // Future.delayed(Duration(milliseconds: 500));
    // print(fields);
    super.initState();
  }

  Future<bool> fetchFields() async {
    fields = await FieldServices.getFieldClubId(1);
    await Future.delayed(Duration(milliseconds: 500));
    // await Future.delayed(Duration(milliseconds: 500), () => setState(() {}));
    return true;
  }

  Future<bool> fetchClub() async {
    club = await ClubService.getById(id: 1);
    Club _club = await ClubService.getById(id: 1);

    await Future.delayed(Duration(milliseconds: 1000));
    // await Future.delayed(Duration(milliseconds: 1000), () => setState(() {}));
    print(club);
    print(_club);
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RaisedButton(onPressed: () {
            fetchClub();
          }),
          // Stack(
          //   children: [
          //     Container(
          //       width: sized(context).width,
          //       height: sized(context).height * 0.4,
          //       child: GetImageNetwork(
          //         landscape: true,
          //         photosPath: club.photosPath,
          //       ),
          //     ),
          //     CustomTopBar(
          //       isOwner: isOwner,
          //       title: club.title,
          //       trailingTap: () {
          //         Navigator.push(
          //           context,
          //           MaterialPageRoute(
          //             builder: (context) => CreateClub(
          //               club: club,
          //               isOwner: true,
          //             ),
          //           ),
          //         );
          //       },
          //     ),
          //   ],
          // ),
          // ...List.generate(
          //   (fields == null) ? 0 : fields.length,
          //   (index) {
          //     return Stack(
          //       children: [
          //         CardField(
          //           field: fields[index],
          //           onTap: () {
          //             print('onTap');
          //           },
          //         ),
          //         isOwner == true
          //             ? OwnerButton(
          //                 onClose: () async {
          //                   print('close');
          //                   var res = await FieldServices.delete(
          //                       id: fields[index].id);
          //                   if (res) {
          //                     await fetchFields();
          //                   } else {
          //                     print('Fail');
          //                   }
          //                 },
          //                 onEdit: () {
          //                   print('edit');
          //                 },
          //               )
          //             : SizedBox(),
          //       ],
          //     );
          //   },
          // ),
          SizedBox(height: 10),
          SizedBox(
            child: isOwner == true
                ? RoundedButton(
                    text: 'Add Field',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CreateField(
                            clubId: club.id,
                          ),
                        ),
                      );
                    },
                  )
                : SizedBox(),
          ),
        ],
      ),
    );
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
