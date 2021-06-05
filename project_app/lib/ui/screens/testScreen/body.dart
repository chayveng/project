import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:project_app/constants.dart';
import 'package:project_app/ui/components/custom_dialog_loading.dart';
import 'package:get/get.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  Widget mainWidget;

  Future<bool> delay() async {
    print('delay');
    await Future.delayed(Duration(milliseconds: 1000));
    return true;
  }

  Future<bool> onClick() async {
    print('onClick');
    await Future.delayed(Duration(milliseconds: 5000));
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return FirstPage();
  }
}

class FirstPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('First Page'),
              ElevatedButton(
                child: Text('Next'),
                onPressed: () {
                  // Get.to(SecondPage());
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => SecondPage(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SecondPage extends StatelessWidget {
  Future<void> _submit() async {
    for (var i = 1; i <= 10; i++) {
      print('${List.generate(i, (index) => '* ').join()}');
      await Future.delayed(Duration(milliseconds: 100));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Second Page'),
              CustomSlider(),
              ElevatedButton(
                child: Text('Submit'),
                onPressed: () async {
                  await showDialog(
                        context: context,
                        builder: (_) => LoadingDialog(
                          onSubmit: _submit(),
                        ),
                      ) ??
                      Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomSlider extends StatefulWidget {
  const CustomSlider({Key key}) : super(key: key);

  @override
  _CustomSliderState createState() => _CustomSliderState();
}

class _CustomSliderState extends State<CustomSlider> {
  List<Widget> lst = [
    Container(color: Colors.redAccent),
    Container(color: Colors.teal),
    Container(color: Colors.amber),
    Container(color: Colors.blueAccent),
  ];
  int _current;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AspectRatio(
          aspectRatio: 1.2,
          child: PageView.builder(
            itemCount: lst.length,
            itemBuilder: (context, index) => lst[index],
            onPageChanged: (index) => setState(() => _current = index),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ...List.generate(
                lst.length,
                (index) => Container(
                  width: 12,
                  height: 12,
                  margin: EdgeInsets.symmetric(horizontal: 3.0),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: index != _current ? Colors.black38 : Colors.black,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class LoadingDialog extends StatefulWidget {
  final Future onSubmit;

  const LoadingDialog({Key key, this.onSubmit}) : super(key: key);

  @override
  _LoadingDialogState createState() => _LoadingDialogState();
}

class _LoadingDialogState extends State<LoadingDialog> {
  @override
  void initState() {
    _onSubmit();
    super.initState();
  }

  Future<void> _onSubmit() async {
    await widget.onSubmit;
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return CustomDialogLoading();
  }
}
