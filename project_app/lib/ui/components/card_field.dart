import 'package:flutter/material.dart';
import 'package:project_app/core/models/Field.dart';
import 'package:project_app/core/services/FieldServices.dart';

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

  @override
  void initState() {
    setDistance();
    super.initState();
  }

  String getDistance(double distance) {
    String str = distance.toString();
    int index = str.indexOf('.');
    return str.substring(0, index + 3);
  }

  Future<bool> setDistance() async {
    double? _distance = await findDistance(widget.field!.location!);
    setState(() {
      distance = _distance!;
    });
    print('${widget.field!.title}: $distance');
    await Future.delayed(Duration(milliseconds: 5000));
    setState(() {});
    return true;
  }

  Future<bool> fetchData() async {
    urlImage = await FieldServices.firstImageUrl(widget.field!.id!);
    await Future.delayed(Duration(milliseconds: 500));
    return true;
  }

  Widget cardField(String url) {
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
            // color: creamPrimaryColor,
            child: Column(
              children: [
                buildImage(url),
                buildDetail(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Padding buildDetail() {
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('${widget.field!.tel}'),
                      Text(distance != null
                          ? '${getDistance(distance!)}'
                          : 'null'),
                      // FutureBuilder(
                      //   future: setDistance(),
                      //   builder:
                      //       (BuildContext context, AsyncSnapshot snapshot) {
                      //     if (snapshot.data == true) {
                      //       return Text(
                      //           '${getDistance(distance!)} กม.');
                      //           // '${distance!.toString().substring(0, distance.toString().indexOf('.') + 3)} กม.');
                      //     } else {
                      //       return SizedBox();
                      //     }
                      //   },
                      // ),
                    ],
                  ),
                ],
              ),
            ),
            widget.isOwner!
                ? Container(
                    padding: EdgeInsets.all(4),
                    // width: 24,
                    // height: 24,
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

  Container buildImage(String url) {
    return Container(
      width: sized(context).width,
      height: 250,
      child: Image.network(
        url,
        fit: BoxFit.cover,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: fetchData(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          return cardField(urlImage!);
        } else {
          return Center(
            child: SizedBox(),
            // child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
