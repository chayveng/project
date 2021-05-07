import 'package:flutter/material.dart';

import '../../../../constants.dart';

class SectionImage extends StatefulWidget {
  final bool isCreate;

  const SectionImage({Key key, this.isCreate}) : super(key: key);

  @override
  _SectionImageState createState() => _SectionImageState();
}

class _SectionImageState extends State<SectionImage> {
  bool option;

  @override
  void initState() {
    option = false;
    super.initState();
  }

  Text buildText(String text) {
    return Text(
      text,
      style: TextStyle(
        fontSize: sized(context).width * 0.2,
      ),
    );
  }

  Widget buildButtonChoose(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8),
      width: sized(context).width,
      child: ElevatedButton(
        child: Text('choose'),
        onPressed: () async {
          option = await showDialog(
            context: context,
            builder: (context) => CustomDialog(),
          );
          setState(() {});
        },
      ),
    );
  }

  Widget buildChooseImage(BuildContext context) {
    return Container(
      width: sized(context).width,
      height: 275,
      color: Colors.redAccent,
      child: Center(
          child: Text(
        '$option',
        style: TextStyle(
          fontSize: 50,
        ),
      )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        buildChooseImage(context),
        buildButtonChoose(context),
      ],
    );
  }

}

class CustomDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Choose Option'),
      content: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ElevatedButton(
            child: Text('true'),
            onPressed: () {
              Navigator.pop(context, true);
            },
          ),
          Text('or'),
          ElevatedButton(
            child: Text('false'),
            onPressed: () {
              Navigator.pop(context, false);
            },
          ),
        ],
      ),
    );
  }
}
