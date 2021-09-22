import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:project_app/core/apis/ApiConnect.dart';
import 'package:project_app/core/models/Field.dart';
import 'package:project_app/core/services/AuthService.dart';
import 'package:project_app/core/services/FieldServices.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../constants.dart';

class CardField extends StatefulWidget {
  final Field? field;
  final bool? isOwner;
  final GestureTapCallback? onTap;
  final GestureTapCallback? onRemove;

  const CardField({
    Key? key,
    @required this.field,
    @required this.onTap,
    @required this.isOwner,
    this.onRemove,
  }) : super(key: key);

  @override
  _CardFieldState createState() => _CardFieldState();
}

class _CardFieldState extends State<CardField> {
  String? urlImage;
  double? distance;
  String? token;

  // @override
  // void initState() {
  //   // print(widget.field);
  //   // setDistance();
  //   // fetchData();
  //   super.initState();
  // }

  // String getDistance(double distance) {
  //   String str = distance.toString();
  //   int index = str.indexOf('.');
  //   return str.substring(0, index + 3);
  // }

  // Future<bool> setDistance() async {
  //   double? _distance = await findDistance(widget.field!.location!);
  //   setState(() => distance = _distance!);
  //   // print('${widget.field!.title}: $distance');
  //   // await Future.delayed(Duration(milliseconds: 5000));
  //   // setState(() {});
  //   return true;
  // }

  Future<bool> fetchData() async {
    var _pref = await SharedPreferences.getInstance();
    token = _pref.getString(AuthService.TOKEN);
    var url = await FieldServices.firstImageUrl(widget.field!.id!);
    if (url != '') {
      urlImage = url;
    }
    await Future.delayed(Duration(milliseconds: 200));
    return true;
  }

  Widget buildDetail() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: sized(context).width,
        height: 100,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${widget.field!.title}',
                    style: TextStyle(
                      color: orangeColor,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text('${widget.field!.hours}'),
                  Text('${widget.field!.price}'),
                  Text('${widget.field!.tel}'),
                ],
              ),
            ),
            widget.isOwner!
                ? Container(
                    padding: EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: Colors.redAccent,
                      shape: BoxShape.circle,
                    ),
                    child: InkWell(
                      onTap: widget.onRemove,
                      child: Icon(
                        Icons.restore_from_trash,
                        color: Colors.white,
                      ),
                    ),
                  )
                : SizedBox(),
          ],
        ),
      ),
    );
  }

  Widget buildImage(BuildContext context) {
    return urlImage != null
        ? Container(
            width: sized(context).width,
            height: 250,
            child: Image.network(
              urlImage!,
              headers: {
                HttpHeaders.authorizationHeader:
                    token != null ? 'Bearer $token' : ''
              },
              fit: BoxFit.cover,
            ),
          )
        : Container(
            width: sized(context).width,
            height: 250,
            child: Opacity(
              opacity: 0.3,
              child: Image.asset(
                'assets/images/default/image_symbol_landscape.png',
              ),
            ),
          );
  }

  Widget fromCardField() {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 7,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: InkWell(
        onTap: widget.onTap,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Material(
            color: whiteColor,
            child: Column(
              children: [
                buildImage(context),
                buildDetail(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: fetchData(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.data == true) {
          return fromCardField();
        } else {
          return Center(
            child: SizedBox(),
          );
        }
      },
    );
  }
}
