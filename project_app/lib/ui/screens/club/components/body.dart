import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:project_app/core/models/Club.dart';
import 'package:project_app/ui/screens/club/components/card_field.dart';
import 'package:project_app/ui/screens/main/main_screen.dart';

import '../../../../constants.dart';

class Body extends StatelessWidget {
  final Club club;

  const Body({Key key, this.club}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size sized = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildHeader(sized, context),
          buildTitleBox(sized),
          listSection(),
          SizedBox(height:15),
          buildCreateButton(sized),
        ],
      ),
    );
  }

  Container buildTitleBox(Size sized) {
    return Container(
      width: sized.width,
      color: creamPrimaryColor,
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Title",
            style: TextStyle(
              fontSize: 14,
              color: greenPrimaryColor,
            ),
          ),
          Text(
            "detail hgeuguerhguerhreuis",
            style: TextStyle(
              fontSize: 14,
              color: greenPrimaryColor,
            ),
          ),
        ],
      ),
    );
  }

  Stack buildHeader(Size sized, BuildContext context) {
    return Stack(
      children: [
        Container(
          width: sized.width,
          height: sized.height * 0.35,
          child: Container(
            child: Image(
              image: AssetImage('assets/images/clubs/club-1.jpg'),
              fit: BoxFit.fill,
            ),
          ),
        ),
        Container(
          width: sized.width,
          height: sized.height * 0.35,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: FractionalOffset.topCenter,
              end: FractionalOffset.bottomCenter,
              colors: [
                Colors.black38.withOpacity(0.8),
                Colors.white10,
              ],
            ),
          ),
        ),
        Positioned(
          left: 15,
          top: sized.height * 0.05,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              IconButton(
                icon: Icon(
                  Icons.arrow_back,
                  color: creamPrimaryColor,
                  size: 30,
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    PageTransition(
                      type: PageTransitionType.fade,
                      child: MainScreen(),
                    ),
                  );
                },
              ),
              SizedBox(width: 20),
              Text(
                'Name',
                style: TextStyle(color: creamPrimaryColor, fontSize: 20),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Center buildCreateButton(Size sized) {
    return Center(
      child: Container(
        width: sized.width * 0.8,
        height: 50,
        child: RaisedButton(
          color: orangePrimaryColor,
          child: Text(
            'Create',
            style: TextStyle(color: greenPrimaryColor),
          ),
          onPressed: () {},
          shape: new RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(10.0),
          ),
        ),
      ),
    );
  }

  Column listSection() {
    return Column(
      children: [
        CardField(
          onTap: () {},
          title: 'สนาม 5-6 คน',
          price: 'ราคา 600 บาท',
          time: '14:00 - 23:00',
        ),
        CardField(
          onTap: () {},
          title: 'สนาม 7-9 คน',
          price: 'ราคา 800 บาท',
          time: '14:00 - 23:00',
        ),
      ],
    );
  }
}
