import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:project_app/core/models/Club.dart';
import 'package:project_app/core/models/Field.dart';
import 'package:project_app/core/services/ClubService.dart';
import 'package:project_app/core/services/FieldServices.dart';
import 'package:project_app/ui/components/get_image_network.dart';
import 'package:project_app/ui/components/rounded_button.dart';
import 'package:project_app/ui/screens/club/components/card_field.dart';
import 'package:project_app/ui/screens/createClub/create_club.dart';
import 'package:project_app/ui/screens/createField/create_field.dart';

import '../../../../constants.dart';
import 'custom_top_bar.dart';

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

  _BodyState(this.clubId, this.isOwner);

  @override
  void initState() {
    fetchData();
    super.initState();
  }

  Future<bool> fetchData() async {
    fields = await FieldServices.fetchFieldClubId(clubId);
    club = await ClubService.getById(id: clubId);
    await Future.delayed(Duration(milliseconds: 500));
    return true;
  }

  Future<void> _delayed() async =>
      await Future.delayed(Duration(milliseconds: 500));
  // await Future.delayed(Duration(milliseconds: 500), () => setState(() {}));

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
                Stack(
                  children: [
                    Container(
                      width: sized(context).width,
                      height: sized(context).height * 0.4,
                      child: GetImageNetwork(
                        landscape: true,
                        photosPath: club.photosPath,
                      ),
                    ),
                    CustomTopBar(
                      isOwner: isOwner,
                      title: club.title,
                      trailingTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CreateClub(
                              club: club,
                              isOwner: true,
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
                ...List.generate(
                  (fields == null) ? 0 : fields.length,
                  (index) {
                    return Stack(
                      children: [
                        CardField(
                          field: fields[index],
                          onTap: () {
                            print('onTap');
                          },
                        ),
                        isOwner == true
                            ? OwnerButton(
                                onClose: () async {
                                  print('close');
                                  var res = await FieldServices.delete(
                                      id: fields[index].id);
                                  if (res) {
                                    await fetchData();
                                    setState(() {});
                                  } else {
                                    print('Fail');
                                  }
                                },
                                onEdit: () {
                                  print('edit');
                                },
                              )
                            : SizedBox(),
                      ],
                    );
                  },
                ),
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
                                  isOwner: isOwner,
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
        } else {
          return SpinKitWave(
            color: orangePrimaryColor,
            size: 40,
          );
        }
      },
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
