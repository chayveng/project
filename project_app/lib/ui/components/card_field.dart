import 'package:flutter/material.dart';
import 'package:project_app/core/models/Field.dart';
import 'package:project_app/core/services/FieldServices.dart';

import '../../constants.dart';

class CardField extends StatefulWidget {
  final Field field;
  final GestureTapCallback onTap;

  const CardField({Key key, @required this.field, @required this.onTap})
      : super(key: key);

  @override
  _CardFieldState createState() => _CardFieldState();
}

class _CardFieldState extends State<CardField> {
  String urlImage;

  Future<bool> fetchData() async {
    urlImage = await FieldServices.firstImageUrl(widget.field.id);
    await Future.delayed(Duration(milliseconds: 500));
    return true;
  }

  Widget cardField(String url) {
    return InkWell(
      onTap: widget.onTap,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Material(
          color: creamPrimaryColor,
          child: Column(
            children: [
              Container(
                width: sized(context).width,
                height: 250,
                child: Image.network(
                  url,
                  fit: BoxFit.cover,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: sized(context).width,
                  height: 100,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${widget.field.title}',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text('${widget.field.hours}'),
                      Text('${widget.field.price}'),
                      Text('${widget.field.tel}'),
                    ],
                  ),
                ),
              ),
            ],
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
        if (snapshot.hasData) {
          return cardField(urlImage);
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
