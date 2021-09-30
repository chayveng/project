import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:project_app/constants.dart';
import 'package:project_app/core/models/Field.dart';
import 'package:project_app/ui/components/card_field.dart';
import 'package:project_app/ui/screens/field/field_screen.dart';

import 'custom_search_bar.dart';

class SectionFields extends StatefulWidget {
  final List<Field>? fields;
  final LatLng? currentLct;

  const SectionFields({Key? key, @required this.fields, this.currentLct})
      : super(key: key);

  @override
  _SectionFieldsState createState() => _SectionFieldsState();
}

class _SectionFieldsState extends State<SectionFields> {
<<<<<<< HEAD
  // @override
  // void initState() {
  //   print(widget.fields!.length);
  //   super.initState();
  // }
=======
  @override
  void initState() {
    print(widget.fields!.length);
    super.initState();
  }
>>>>>>> master

  void _onTap(int index) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FieldScreen(
          isOwner: false,
          fieldId: widget.fields![index].id!,
        ),
      ),
    );
  }

  Widget formCardField(int index) {
    return Padding(
      padding: EdgeInsets.only(
        top: 8.0,
        left: 8.0,
        right: 8.0,
        bottom: index == widget.fields!.length - 1 ? 8.0 : 0,
      ),
      child: CardField(
        field: widget.fields![index],
        onTap: () => _onTap(index),
        isOwner: false,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomSearchBar(fields: widget.fields),
        Expanded(
          child: ListView.builder(
            padding: EdgeInsets.all(0),
            itemCount: widget.fields!.length,
            itemBuilder: (context, index) {
              return formCardField(index);
            },
          ),
        ),
      ],
    );
  }
}
