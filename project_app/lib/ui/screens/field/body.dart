import 'dart:convert';
import 'dart:typed_data';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:project_app/constants.dart';
import 'package:project_app/core/apis/ApiConnect.dart';
import 'package:project_app/core/models/Field.dart';
import 'package:project_app/core/services/FieldServices.dart';
import 'package:project_app/ui/screens/field/components/section_general.dart';
import 'package:project_app/ui/screens/field/components/section_time.dart';
import 'package:project_app/ui/screens/field/create/create_field_screen.dart';

import 'components/custom_appBar.dart';
import 'components/section_detail.dart';
import 'components/section_images.dart';

class Body extends StatefulWidget {
  final bool? isOwner;
  final int? fieldId;

  const Body({Key? key, @required this.isOwner, this.fieldId})
      : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  Field field = Field();
  bool isEdit = false;
  List<Uint8List> images = [];

  @override
  void initState() {
    print(widget.fieldId);
    fetchData();
    super.initState();
  }

  Future<void> fetchData() async {
    print('fetch');
    field = await FieldServices.findById(widget.fieldId!);
    // await downloadImages();
    await Future.delayed(Duration(milliseconds: 1000), () => setState(() {}));
  }

  // Future<void> downloadImages() async {
  //   // images = [];
  //   List urlImages = [];
  //   if (widget.fieldId != null) {
  //     String path = '/field/urlImages/${widget.fieldId}';
  //     var res = await ApiConnect.get(path: path);urlImages = jsonDecode(res.toString());
  //     for (var i = 0; i < urlImages.length; i++) {
  //       var url = Uri.parse(urlImages[i]);
  //       var res = await http.get(url);
  //       images.add(res.bodyBytes);
  //       setState(() {});
  //     }
  //   }
  //   print('images: ${images.length}');
  // }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: sized(context).width,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomAppBar(
              isOwner: widget.isOwner!,
              onEdit: () async {
                print('to field screen');
                await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CreateFieldScreen(
                          isCreate: false,
                          fieldId: field.id!,
                        ),
                      ),
                    ) ??
                    fetchData();
              },
            ),
            SectionImages(images: []),
            SectionDetail(
              tabBars: ['General', 'Times'],
              tabViews: [
                SectionGeneral(field: field),
                SectionTimes(times: []),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
