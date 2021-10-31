import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project_app/core/services/AuthService.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../constants.dart';

class SectionImages extends StatefulWidget {
  final List? urlImages;

  const SectionImages({Key? key, this.urlImages})
      : super(key: key);

  @override
  _SectionImagesState createState() => _SectionImagesState();
}

class _SectionImagesState extends State<SectionImages> {
  int? _current = 0;
  String _token = '';

  @override
  initState() {
    getToken();
    super.initState();
  }

  Future getToken() async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    String? token = _pref.getString(AuthService.TOKEN);
    _token = token!;
    setState(() {});
  }

  Widget indicator() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ...List.generate(
              widget.urlImages!.length,
              (index) {
                return Container(
                  width: 8.0,
                  height: 8.0,
                  margin: EdgeInsets.symmetric(vertical: 10, horizontal: 2),
                  decoration: BoxDecoration(
                    color: _current == index ? Colors.black87 : Colors.black12,
                    shape: BoxShape.circle,
                  ),
                );
              },
            ),
          ],
        ),
      ],
    );
  }

  Widget formImages() {
    return widget.urlImages!.length != 0
        ? Container(
            height: 250,
            width: sized(context).width,
            child: PageView.builder(
              itemCount: widget.urlImages!.length, // Can be null
              onPageChanged: (index) => setState(() => _current = index),
              itemBuilder: (context, index) {
                return Container(
                    child: Image.network(
                  widget.urlImages![index],
                  fit: BoxFit.cover,
                  headers: {
                    HttpHeaders.authorizationHeader:
                        _token != null ? 'Bearer $_token' : ''
                  },
                ));
              },
            ),
          )
        : Container(
            height: 250,
            width: sized(context).width,
            child: Opacity(
              opacity: 0.3,
              child: Image.asset(
                'assets/images/default/image_symbol_landscape.png',
              ),
            ),
          );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      width: sized(context).width,
      child: Column(
        children: [
          formImages(),
          indicator(),
        ],
      ),
    );
  }
}
