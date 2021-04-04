import 'package:flutter/material.dart';

import '../../../constants.dart';

class TestScreen extends StatelessWidget {
  static String routeName = '/test_screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   elevation: 0,
      //   title: Text(
      //     'TestScreen',
      //   ),
      // ),

      // body: FeedJsonData(),
      // body: CustomTimePicker(),
      // body: CustomAppBarListViewButton(),
      // body: TimeListSection(),
      // body: SizePositionPage(),
      // body: SimpleAnimatedList(),
      // body: SectionGreen(),
      body: Body(),
    );
  }
}

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [],
      ),
    );
  }
}

class FormField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: [
          TextFormField(

          ),
        ],
      ),
    );
  }
}
