import 'package:flutter/material.dart';
import 'package:project_app/config/Config.dart';
import 'package:project_app/core/models/Club.dart';
import 'package:project_app/core/models/Field.dart';
import 'package:project_app/core/services/ClubService.dart';
import 'package:project_app/core/services/FieldServices.dart';
import 'package:project_app/ui/components/get_image_network.dart';
import 'package:project_app/ui/screens/club/components/card_field.dart';
import 'package:project_app/ui/screens/field/field_screen.dart';

import '../../../../constants.dart';

class Body extends StatefulWidget {
  final Club club;

  Body({Key key, this.club}) : super(key: key);

  @override
  _BodyState createState() => _BodyState(club);
}

class _BodyState extends State<Body> {
  final Club club;
  List<Field> fields = new List<Field>();

  _BodyState(this.club);

  @override
  void initState() {
    fetchFields();
    super.initState();
  }

  Future<void> fetchFields() async {
    await Future.delayed(Duration(milliseconds: 500));
    fields = await FieldServices.fetchFieldClubId(club.id);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Container(
                width: sized(context).width,
                height: sized(context).height * 0.35,
                child: GetImageNetwork(
                  landscape: true,
                  photosPath: club.photosPath,
                ),
              ),
              Container(
                width: sized(context).width,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: FractionalOffset.topCenter,
                    end: FractionalOffset.bottomCenter,
                    colors: [Colors.black.withOpacity(0.8), Colors.transparent],
                    stops: [0.1, 0.9],
                  ),
                ),
                child: Column(
                  children: [
                    SafeArea(child: SizedBox()),
                    ListTile(
                      leading: IconButton(
                        icon: Icon(
                          Icons.arrow_back_ios,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                      title: Text(
                        club.title,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(height: 30),
                  ],
                ),
              ),
            ],
          ),
          ...List.generate(
            (fields == null) ? 0 : fields.length,
            (index) {
              return Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Container(
                  padding: EdgeInsets.all(8),
                  width: sized(context).width,
                  color: creamPrimaryColor,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        fields[index].title,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(fields[index].detail),
                      Text(fields[index].price),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
