import 'package:flutter/material.dart';

class CustomAppBarListViewButton extends StatefulWidget {
  @override
  _CustomAppBarListViewButtonState createState() =>
      _CustomAppBarListViewButtonState();
}

class _CustomAppBarListViewButtonState
    extends State<CustomAppBarListViewButton> {
  @override
  Widget build(BuildContext context) {
    Size sized = MediaQuery.of(context).size;
    return SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(color: Colors.black45, height: 50, width: sized.width),
          Expanded(
            child: Stack(
              children: [
                ListView.builder(
                  itemBuilder: (context, index) => buildPadding(sized),
                ),
                Positioned(
                  child: Align(
                    alignment: FractionalOffset.bottomCenter,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: Container(
                        height: 75,
                        width: sized.width * 0.8,
                        decoration: BoxDecoration(
                          color: Colors.yellow,
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Padding buildPadding(Size sized) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 50,
        width: sized.width,
        color: Colors.red,
      ),
    );
  }
}
