import 'package:flutter/material.dart';
import 'package:project_app/core/models/Club.dart';
import '../../../../constants.dart';

class CardClub extends StatelessWidget {
  final AssetImage image;
  final GestureTapCallback onTap;
  final Club club;
  final VoidCallback onPressed;

  const CardClub({
    Key key,
    this.image,
    @required this.onTap,
    @required this.club,
    @required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size sized = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.only(top: 8, left: 8, right: 8),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Material(
          color: creamPrimaryColor,
          child: InkWell(
            onTap: onTap,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 250,
                  width: sized.width,
                  child: Image(
                    image: AssetImage(club.photoPath),
                    fit: BoxFit.fill,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding:
                              const EdgeInsets.only(left: 8, top: 8, right: 8),
                          child: Text(
                            club.title,
                            style: TextStyle(
                              fontSize: 14,
                              color: greenPrimaryColor,
                            ),
                          ),
                        ),
                        Container(
                          width: sized.width * 0.6,
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            club.price,
                            // 'psdhfiew sdpofjiodf eriuhger uwiehfiwu wiehwihe weihw iewhr iuhewr',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 14,
                              color: greenPrimaryColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      margin: EdgeInsets.all(10),
                      width: sized.width * 0.25,
                      height: 40,
                      child: RaisedButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        color: orangePrimaryColor,
                        child: Text(
                          'จอง',
                          style:
                              TextStyle(fontSize: 14, color: greenPrimaryColor),
                        ),
                        onPressed: onPressed,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
