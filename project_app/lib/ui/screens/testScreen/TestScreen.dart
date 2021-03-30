import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:project_app/constants.dart';

class TestScreen extends StatefulWidget {
  static String routeName = '/test_screen';

  @override
  _TestScreenState createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  bool status = false;

  @override
  Widget build(BuildContext context) {
    Size sized = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.red, // status bar color
          brightness: Brightness.dark // status bar brightness
        ),
      // body: buildCenter(),
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 50),
            Container(
              child: RaisedButton(
                child: Text('click'),
                onPressed: () async {
                  // Navigator.push(context, MaterialPageRoute(builder: (context) => NewPage(),),);
                  setState(() {
                    status = !status;
                    print('1');
                  });
                  await Future.delayed(Duration(milliseconds: 1500));
                  setState(() {
                    status = !status;
                    print('2');
                  });
                },
              ),
            ),
            status == true ? buildSpinKit() : SizedBox(),
            RaisedButton(
                child: Text('Dialog'),
                onPressed: () {
                  buildDialogLoading(context, 1500);

                  // showDialog(
                  //     context: context,
                  //     barrierDismissible: false,
                  //     builder: (context) {
                  //       Future.delayed(Duration(milliseconds: 1500), () {
                  //         Navigator.of(context).pop();
                  //       });
                  //       return CustomDialogLoading();
                  //     });
                }),
            // ShowLoading()
          ],
        ),
      ),
    );
  }

  Center buildSpinKit() {
    return Center(
      child: SpinKitWave(
        color: orangePrimaryColor,
        size: 60,
        duration: Duration(milliseconds: 1500),
      ),
    );
  }
}
