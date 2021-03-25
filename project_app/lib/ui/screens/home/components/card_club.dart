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
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                buildImage(sized),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          buildTitle(),
                          buildDetail(sized),
                        ],
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

  Container buildImage(Size sized) {
    return Container(
      height: 250,
      width: sized.width,
      child: Image(
        image: AssetImage(club.photoPath),
        fit: BoxFit.fill,
      ),
      // child: FlutterLogo(),
    );
  }

  Container buildTitle() {
    return Container(
      padding: const EdgeInsets.only(top: 8.0, left: 8.0, right: 8.0),
      child: Text(
        (club.title) ?? 'null',
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  Container buildDetail(Size sized) {
    return Container(
      width: sized.width,
      padding: const EdgeInsets.all(8.0),
      child: Text(
        club.detail ?? 'null',
        style: TextStyle(
          fontSize: 14,
        ),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
