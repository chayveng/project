import 'package:flutter/material.dart';
import '../../../../constants.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size sized = MediaQuery.of(context).size;
    return Container(
      child: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(15),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
                color: creamPrimaryColor
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.all(20),
                    height: 200,
                    width: sized.width * 0.5,
                    child: FlutterLogo(),
                  ),
                  Container(
                    padding: EdgeInsets.all(20),
                    width: sized.width,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'Club name : ......',
                          style:
                              TextStyle(fontSize: 18, color: greenPrimaryColor),
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Field name : ...... ',
                          style:
                              TextStyle(fontSize: 18, color: greenPrimaryColor),
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Time :      -     ',
                          style:
                              TextStyle(fontSize: 18, color: greenPrimaryColor),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
