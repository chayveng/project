import 'dart:convert';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:project_app/config/Config.dart';
import 'package:project_app/core/apis/ApiConnect.dart';
import 'package:project_app/core/apis/ClubApi.dart';
import 'package:project_app/core/models/Club.dart';
import 'package:project_app/core/services/ClubService.dart';
import 'package:project_app/core/services/UserService.dart';

import 'components/sectionField/section_field.dart';
import 'components/sectionImages/section_image.dart';

class Body extends StatefulWidget {
  final int clubId;
  final bool isCreate;

  const Body({Key key, this.clubId, this.isCreate}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final _formKey = GlobalKey<FormState>();
  Club club = Club();
  List<Uint8List> images = [];

  @override
  void initState() {
    fetchData();
    super.initState();
  }

  Future<void> update({Club club}) async {
    var response = await ClubApi.update(club: club);
    if (response.status == 1 && images.isNotEmpty)
        await _uploadImages(club.id);
  }

  Future<void> create({Club club}) async {
    var response = await ClubApi.create(club: club);
    if (response.status == 1 && images.isNotEmpty)
        await _uploadImages(club.id);
  }

  Future<void> onSubmit() async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      widget.isCreate ? await update(club: club) : await create(club: club);
      // var response = widget.isCreate ? await ClubService.update(club: club, image: )
    }
  }

  Future<void> _uploadImages(int clubId) async {
    String url = '${Config.API_URL}/club/image-uploads/';
    FormData data = FormData.fromMap({"clubId": clubId});
    for (int i = 0; i < images.length; i++) {
      data.files.addAll([
        MapEntry(
            "files",
            MultipartFile.fromBytes(
              images[i],
              filename: '$i.png',
            )),
      ]);
    }
    Dio dio = Dio();
    await dio.post(url, data: data);
  }

  Future<void> _downloadImages(int clubId) async {
    images = [];
    String url = '/club/urlImages/$clubId';
    var response = await ApiConnect.get(path: url);
    List urlImages = jsonDecode(response);
    var res = await http.get(urlImages[0]);
    for (var _url in urlImages) {
      var res = await http.get(_url);
      setState(() => images.add(res.bodyBytes));
    }
  }

  void fetchData() async {
    print('clubId: ${widget.clubId}');
    club = widget.clubId != null
        ? await ClubService.getById(id: widget.clubId)
        : Club(userId: await UserService.getUserId());
    if (widget.clubId != null) await _downloadImages(club.id);
    await Future.delayed(Duration(milliseconds: 200), () => setState(() {}));
    print(club.id);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SectionImage(
                images: images,
                upload: () async => await _uploadImages(1),
                download: () async => await _downloadImages(1),
              ),
              SizedBox(height: 10),
              SectionField(
                club: club,
                isCreate: widget.isCreate,
                formKey: _formKey,
                onSubmit: () async => await onSubmit(),
              )
            ],
          ),
        ),
      ),
    );
  }
}
